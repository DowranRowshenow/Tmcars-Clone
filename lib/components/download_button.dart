import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/download_controller.dart';
import '../utils/downloader.dart';
// import 'show_toast.dart';

class DownloadButton extends StatelessWidget {
  final String url;
  final DownloadController downloadController;

  const DownloadButton({
    super.key,
    required this.url,
    required this.downloadController,
  });

  void _handleDownload() async {
    if (downloadController.isDownloading.value) {
      return;
    }

    // Reset all download states at the start
    downloadController.reset();
    downloadController.isDownloading.value = true;
    // ToastHelper.showToast(message: "Download started!");

    final token = DownloadCancellationToken();
    downloadController.currentDownloadCancellationToken.value = token;

    try {
      final success = await downloadFromUrl(
        url,
        onProgress: (receivedBytes, totalBytes) {
          downloadController.downloadProgress.value =
              receivedBytes / totalBytes;
        },
        cancellationToken: token,
      );

      // Set download complete based on the return value
      if (!token.isCancelled) {
        downloadController.isDownloadComplete.value = success;
      } else {
        // Reset to false if cancelled
        downloadController.isDownloadComplete.value = false;
      }
    } catch (e) {
      // Always set to false on any error
      downloadController.isDownloadComplete.value = false;
      if (!token.isCancelled) {
        // Only show toast if not cancelled
        // ToastHelper.showToast(message: "Download failed: $e");
      }
    } finally {
      downloadController.isDownloading.value = false;
    }
  }

  void _cancelDownload() {
    if (downloadController.isDownloading.value &&
        !downloadController
            .currentDownloadCancellationToken
            .value
            .isCancelled) {
      downloadController.currentDownloadCancellationToken.value.cancel();
      downloadController.isDownloadComplete.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: downloadController.isDownloading,
      builder: (context, isDownloadingValue, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: downloadController.isDownloadComplete,
          builder: (context, isDownloadCompleteValue, child) {
            Widget iconWidget;
            if (isDownloadingValue) {
              iconWidget = SizedBox(
                width: 25,
                height: 25,
                child: ValueListenableBuilder<double>(
                  valueListenable: downloadController.downloadProgress,
                  builder: (context, downloadProgressValue, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: downloadProgressValue > 0.0
                              ? downloadProgressValue
                              : null,
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                        const Icon(Icons.close, color: Colors.white, size: 16),
                      ],
                    );
                  },
                ),
              );
            } else if (isDownloadCompleteValue) {
              iconWidget = const Icon(Icons.download_done, color: Colors.white);
            } else {
              iconWidget = const Icon(
                Icons.download_outlined,
                color: Colors.white,
              );
            }

            return IconButton(
              splashColor: Colors.transparent,
              splashRadius: Constants.splashRadius,
              onPressed: isDownloadCompleteValue
                  ? null
                  : isDownloadingValue
                  ? _cancelDownload
                  : _handleDownload,
              icon: iconWidget,
            );
          },
        );
      },
    );
  }
}
