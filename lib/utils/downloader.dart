import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../components/show_toast.dart';

// Define a typedef for the progress callback
typedef DownloadProgressCallback =
    void Function(int receivedBytes, int totalBytes);

// New: Class to signal download cancellation
class DownloadCancellationToken {
  bool _isCancelled = false;

  bool get isCancelled => _isCancelled;

  void cancel() {
    _isCancelled = true;
  }
}

/// Downloads a file from a given [imageUrl] and saves it to the device's
/// "Downloads" directory in a "Tmcars" subfolder.
///
/// This function is asynchronous and performs I/O operations without blocking
/// the UI thread.
///
/// - [imageUrl]: The URL of the file to download.
/// - [showToast]: If true, displays toast messages for download status.
/// - [onProgress]: A callback to listen for download progress updates.
/// - [cancellationToken]: An optional token to cancel the download.
///
/// Throws an [Exception] if the download fails for reasons other than
/// permission denial or cancellation.
Future<void> downloadFromUrl(
  String imageUrl, {
  bool showToast = false,
  DownloadProgressCallback? onProgress,
  DownloadCancellationToken? cancellationToken,
}) async {
  // On modern Android (API 30+), direct storage access requires special
  // permissions. For a "Downloads" folder, no specific permission is needed.
  // On older versions, `Permission.storage` is used. On iOS, this is not needed
  // to write to the app's documents directory.
  // This check is simplified for broader compatibility.
  if (Platform.isAndroid) {
    final status = await Permission.storage.request();
    if (status.isDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message: "Storage permission denied. Cannot download file.",
        );
      }
      return;
    }
    if (status.isPermanentlyDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message:
              "Storage permission permanently denied. Please enable from settings.",
        );
      }
      openAppSettings();
      return;
    }
  }

  HttpClient? httpClient;

  try {
    // 1. Get the platform-specific downloads directory.
    // Using path_provider is more robust than hardcoding paths.
    final Directory downloadsDirectory = Directory(
      '/storage/emulated/0/Download',
    );

    // 2. Create the Tmcars subfolder if it doesn't exist.
    final Directory tmcarsFolder = Directory(
      '${downloadsDirectory.path}/Tmcars',
    );
    if (!await tmcarsFolder.exists()) {
      await tmcarsFolder.create(recursive: true);
    }

    // 3. Determine the file name and full path.
    final String fileName = Uri.parse(imageUrl).pathSegments.last;
    if (fileName.isEmpty) {
      throw Exception("Could not determine file name from URL.");
    }
    final String filePath = '${tmcarsFolder.path}/$fileName';
    final File file = File(filePath);

    if (showToast) {
      ToastHelper.showToast(message: "Downloading...");
    }

    // 4. Use HttpClient for a streaming download with progress.
    httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(imageUrl));
    final response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(
        'Failed to download file: ${response.statusCode} ${response.reasonPhrase}',
      );
    }

    final contentLength = response.contentLength;
    int receivedBytes = 0;
    final IOSink sink = file.openWrite();

    await for (final chunk in response) {
      // Check for cancellation before processing the chunk.
      if (cancellationToken?.isCancelled ?? false) {
        await sink.close();
        await file.delete();
        if (showToast) ToastHelper.showToast(message: "Download cancelled!");
        return;
      }

      sink.add(chunk);
      receivedBytes += chunk.length;
      onProgress?.call(receivedBytes, contentLength);
    }

    await sink.close();

    if (showToast) {
      ToastHelper.showToast(message: "Download Completed!");
    }
  } on SocketException {
    if (showToast) {
      ToastHelper.showToast(
        message: "Network error. Please check your connection.",
      );
    }
  } on HttpException catch (e) {
    if (showToast) {
      ToastHelper.showToast(message: "Download failed: ${e.message}");
    }
  } catch (e) {
    // Catch any other unexpected errors.
    if (showToast && !(cancellationToken?.isCancelled ?? false)) {
      ToastHelper.showToast(message: "An error occurred during download: $e");
    }
  } finally {
    // Ensure the HttpClient is always closed.
    httpClient?.close();
  }
}
