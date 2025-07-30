import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../components/show_toast.dart'; // Ensure this path is correct

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

Future<void> downloadFromUrl(
  String imageUrl, {
  bool showToast = false,
  DownloadProgressCallback? onProgress,
  DownloadCancellationToken?
  cancellationToken, // New: Optional cancellation token
}) async {
  // 1. Request Storage Permission
  var status = await Permission.storage.request();
  if (status.isDenied && showToast) {
    ToastHelper.showToast(
      message: "Storage permission denied. Cannot download file.",
    );
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

  HttpClient? httpClient;
  File? file;
  String? filePath; // Declare filePath here to be accessible in finally

  try {
    if (showToast) {
      ToastHelper.showToast(message: "Downloading...");
    }
    // 2. Get the Downloads directory using path_provider for better cross-platform compatibility
    Directory? downloadsDirectory = Directory('/storage/emulated/0/Download');

    // 3. Create the Tmcars subfolder
    final Directory tmcarsFolder = Directory(
      '${downloadsDirectory.path}/Tmcars',
    );
    if (!await tmcarsFolder.exists()) {
      await tmcarsFolder.create(recursive: true);
    }

    // 4. Extract file name from URL
    final String fileName = Uri.parse(
      imageUrl,
    ).pathSegments.last.split('?').first;
    if (fileName.isEmpty) {
      throw Exception("Could not determine file name from URL.");
    }
    filePath = '${tmcarsFolder.path}/$fileName'; // Assign to filePath

    // 5. Use HttpClient for streaming download with progress
    httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(imageUrl));
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      final contentLength = response.contentLength;
      int receivedBytes = 0;

      file = File(filePath);
      final sink = file.openWrite();

      await for (var chunk in response) {
        if (cancellationToken != null && cancellationToken.isCancelled) {
          // New: Check for cancellation
          if (showToast) {
            ToastHelper.showToast(message: "Download cancelled!");
          }
          response.listen(null).cancel(); // Abort the remaining response stream
          await sink.close();
          await file.delete(); // Delete partially downloaded file
          return; // Exit the function
        }

        sink.add(chunk);
        receivedBytes += chunk.length;
        // Report progress
        if (onProgress != null && contentLength != -1) {
          onProgress(receivedBytes, contentLength);
        }
      }
      await sink.close();

      if (showToast) {
        ToastHelper.showToast(message: "Download Completed!");
      }
    } else {
      throw Exception(
        'Failed to download file. Status: ${response.statusCode}',
      );
    }
  } catch (e) {
    if (cancellationToken != null &&
        !cancellationToken.isCancelled &&
        showToast) {
      ToastHelper.showToast(message: "An error occurred during download!");
    }
    if (filePath != null) {
      final partialFile = File(filePath);
      if (await partialFile.exists()) {
        await partialFile.delete();
      }
    }
  } finally {
    httpClient?.close(); // Close the HttpClient
  }
}
