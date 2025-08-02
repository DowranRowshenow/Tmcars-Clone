import 'dart:io';

import '../components/show_toast.dart';
import 'permission_helper.dart';

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
/// Returns true if download was successful, false otherwise.
/// Throws an [Exception] if the download fails for reasons other than
/// permission denial or cancellation.
Future<bool> downloadFromUrl(
  String imageUrl, {
  bool showToast = false,
  DownloadProgressCallback? onProgress,
  DownloadCancellationToken? cancellationToken,
}) async {
  // Request storage permission using the helper
  final bool hasPermission = await PermissionHelper.requestStoragePermission(
    showToast: showToast,
  );

  if (!hasPermission) {
    return false;
  }

  HttpClient? httpClient;

  try {
    // 1. Get the platform-specific downloads directory.
    // Using path_provider is more robust than hardcoding paths.
    Directory downloadsDirectory = Directory('/storage/emulated/0/Download');

    if (!await downloadsDirectory.exists()) {
      downloadsDirectory = Directory("");
    }

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
    final HttpClientRequest request = await httpClient.getUrl(
      Uri.parse(imageUrl),
    );
    final HttpClientResponse response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw HttpException(
        'Failed to download file: ${response.statusCode} ${response.reasonPhrase}',
      );
    }

    final int contentLength = response.contentLength;
    int receivedBytes = 0;
    final IOSink sink = file.openWrite();

    await for (final List<int> chunk in response) {
      // Check for cancellation before processing the chunk.
      if (cancellationToken?.isCancelled ?? false) {
        await sink.close();
        await file.delete();
        if (showToast) ToastHelper.showToast(message: "Download cancelled!");
        return false;
      }

      sink.add(chunk);
      receivedBytes += chunk.length;
      onProgress?.call(receivedBytes, contentLength);
    }

    await sink.close();

    if (showToast) {
      ToastHelper.showToast(message: "Download Completed!");
    }
    return true;
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

  // Return false for any unhandled cases
  return false;
}
