import 'dart:io';

import 'package:flutter/material.dart';

import '../helper/constants.dart' as constants;
import '../l10n/app_localizations.dart';

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
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: constants.appColors.themedSurface,
        elevation: constants.elevation,
        title: Text(
          AppLocalizations.of(context)!.confirmExit,
          style: TextStyle(color: constants.appColors.textThemeColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: TextStyle(color: constants.colorPrimary),
            ),
            onPressed: () => exit(0),
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.no,
              style: TextStyle(color: constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
