import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../providers/themes.dart';
import '../utils/constants.dart';

Future<bool?> showPermissionDialog({
  required BuildContext context,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withValues(alpha: Constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final AppColors appColors = Theme.of(
        dialogContext,
      ).extension<AppColors>()!;
      return PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: appColors.themedSurface,
          elevation: Constants.elevation,
          title: Text(
            "Localization.permissionRequest",
            style: TextStyle(color: appColors.textThemeColor),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 24.0, 0),
          contentTextStyle: TextStyle(color: appColors.textHintThemeColor),
          content: const Text("Localization.permissionRequestContext"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
              ),
              onPressed: () {
                openAppSettings(); // This function from permission_handler opens app settings
              },
              child: const Text("Localization.openSettings.toUpperCase()"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Localization.cancel.toUpperCase()"),
            ),
          ],
        ),
      );
    },
  );
}
