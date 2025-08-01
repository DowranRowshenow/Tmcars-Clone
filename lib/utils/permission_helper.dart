import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../components/show_toast.dart';

/// A helper class to handle permission requests for different platforms and Android versions
class PermissionHelper {
  /// Request storage permission for downloading files
  ///
  /// This method handles different permission requirements for:
  /// - Android 13+ (API 33+): Uses READ_MEDIA_IMAGES permission
  /// - Older Android versions: Uses storage permission
  /// - iOS: No permission required for app's documents directory
  ///
  /// Returns true if permission is granted, false otherwise
  static Future<bool> requestStoragePermission({
    bool showToast = true,
    String? customDeniedMessage,
    String? customPermanentlyDeniedMessage,
  }) async {
    if (!Platform.isAndroid) {
      // iOS doesn't need storage permission for app's documents directory
      return true;
    }

    PermissionStatus status;

    // Try photos permission first (Android 13+)
    status = await Permission.photos.request();
    if (status.isGranted) {
      return true;
    }

    // If photos permission is denied, try storage permission for older Android
    if (status.isDenied) {
      status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }
    }

    // Handle denied permissions
    if (status.isDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message:
              customDeniedMessage ??
              "Storage permission denied. Cannot download file.",
        );
      }
      return false;
    }

    // Handle permanently denied permissions
    if (status.isPermanentlyDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message:
              customPermanentlyDeniedMessage ??
              "Storage permission permanently denied. Please enable from settings.",
        );
      }
      openAppSettings();
      return false;
    }

    return false;
  }

  /// Request camera permission
  ///
  /// Returns true if permission is granted, false otherwise
  static Future<bool> requestCameraPermission({
    bool showToast = true,
    String? customDeniedMessage,
    String? customPermanentlyDeniedMessage,
  }) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message: customDeniedMessage ?? "Camera permission denied.",
        );
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message:
              customPermanentlyDeniedMessage ??
              "Camera permission permanently denied. Please enable from settings.",
        );
      }
      openAppSettings();
      return false;
    }

    return false;
  }

  /// Request notification permission (required for Android 13+)
  ///
  /// Returns true if permission is granted, false otherwise
  static Future<bool> requestNotificationPermission({
    bool showToast = true,
    String? customDeniedMessage,
    String? customPermanentlyDeniedMessage,
  }) async {
    if (!Platform.isAndroid) {
      // iOS handles notifications differently
      return true;
    }

    final status = await Permission.notification.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message: customDeniedMessage ?? "Notification permission denied.",
        );
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      if (showToast) {
        ToastHelper.showToast(
          message:
              customPermanentlyDeniedMessage ??
              "Notification permission permanently denied. Please enable from settings.",
        );
      }
      openAppSettings();
      return false;
    }

    return false;
  }

  /// Check if storage permission is granted
  static Future<bool> isStoragePermissionGranted() async {
    if (!Platform.isAndroid) {
      return true;
    }

    // Check photos permission first (Android 13+)
    if (await Permission.photos.isGranted) {
      return true;
    }

    // Check storage permission for older Android
    return await Permission.storage.isGranted;
  }

  /// Check if camera permission is granted
  static Future<bool> isCameraPermissionGranted() async {
    return await Permission.camera.isGranted;
  }

  /// Check if notification permission is granted
  static Future<bool> isNotificationPermissionGranted() async {
    if (!Platform.isAndroid) {
      return true;
    }
    return await Permission.notification.isGranted;
  }

  /// Open app settings
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Request multiple permissions at once
  ///
  /// Returns a map of permission types to their status
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }
}
