import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/downloader.dart';
// import 'show_toast.dart';

class DownloadButton extends StatelessWidget {
  final String url;
  final ValueNotifier<bool> isDownloadingNotifier;
  final ValueNotifier<double> downloadProgressNotifier;
  final ValueNotifier<DownloadCancellationToken?> cancellationTokenNotifier;
  final ValueNotifier<bool> isDownloadCompleteNotifier;

  const DownloadButton({
    super.key,
    required this.url,
    required this.isDownloadingNotifier,
    required this.downloadProgressNotifier,
    required this.cancellationTokenNotifier,
    required this.isDownloadCompleteNotifier,
  });

  void _handleDownload() async {
    if (isDownloadingNotifier.value) {
      return;
    }

    isDownloadingNotifier.value = true;
    downloadProgressNotifier.value = 0.0;
    isDownloadCompleteNotifier.value = false;
    // ToastHelper.showToast(message: "Download started!");

    final token = DownloadCancellationToken();
    cancellationTokenNotifier.value = token;

    try {
      await downloadFromUrl(
        url,
        showToast: false,
        onProgress: (receivedBytes, totalBytes) {
          downloadProgressNotifier.value = receivedBytes / totalBytes;
        },
        cancellationToken: token,
      );
      if (!token.isCancelled) {
        isDownloadCompleteNotifier.value = true;
        // ToastHelper.showToast(message: "Download completed!");
      }
    } catch (e) {
      if (!token.isCancelled) {
        // Only show toast if not cancelled
        // ToastHelper.showToast(message: "Download failed: $e");
      }
      isDownloadCompleteNotifier.value = false;
    } finally {
      isDownloadingNotifier.value = false;
    }
  }

  void _cancelDownload() {
    if (isDownloadingNotifier.value &&
        cancellationTokenNotifier.value != null &&
        !cancellationTokenNotifier.value!.isCancelled) {
      cancellationTokenNotifier.value!.cancel();
      isDownloadCompleteNotifier.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDownloadingNotifier,
      builder: (context, isDownloadingValue, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDownloadCompleteNotifier,
          builder: (context, isDownloadCompleteValue, child) {
            Widget iconWidget;
            if (isDownloadingValue) {
              iconWidget = SizedBox(
                width: 25,
                height: 25,
                child: ValueListenableBuilder<double>(
                  valueListenable: downloadProgressNotifier,
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
