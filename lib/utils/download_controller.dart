import 'package:flutter/foundation.dart';

import '../utils/downloader.dart';

class DownloadController {
  final isDownloadComplete = ValueNotifier<bool>(false);
  final isDownloading = ValueNotifier<bool>(false);
  final downloadProgress = ValueNotifier<double>(0.0);
  final currentDownloadCancellationToken =
      ValueNotifier<DownloadCancellationToken>(DownloadCancellationToken());

  /// Reset all download states to initial values
  void reset() {
    isDownloadComplete.value = false;
    isDownloading.value = false;
    downloadProgress.value = 0.0;
    currentDownloadCancellationToken.value.cancel();
    currentDownloadCancellationToken.value = DownloadCancellationToken();
  }

  void dispose() {
    isDownloadComplete.dispose();
    isDownloading.dispose();
    downloadProgress.dispose();
    currentDownloadCancellationToken.value.cancel();
    currentDownloadCancellationToken.dispose();
  }
}
