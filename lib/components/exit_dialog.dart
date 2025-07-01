import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';

import '../helper/constants.dart' as constants;
import '../helper/strings.dart';

Future<T?> showExitDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = constants.blurSigmaX,
  double blurSigmaY = constants.blurSigmaY,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black.withAlpha(constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: constants.blurSigmaX,
          sigmaY: constants.blurSigmaY,
        ),
        child: AlertDialog(
          backgroundColor: constants.appColors.themedSurface?.withAlpha(170),
          elevation: constants.elevation,
          title: Text(
            Localization.confirmExit,
            style: TextStyle(color: constants.appColors.textThemeColor),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
              ),
              child: Text(
                Localization.yes,
                style: TextStyle(color: constants.colorPrimary),
              ),
              onPressed: () => exit(0),
            ),
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
              ),
              child: Text(
                Localization.no,
                style: TextStyle(color: constants.colorPrimary),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    },
  );
}
