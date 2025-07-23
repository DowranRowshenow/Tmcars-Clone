import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/themes.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';

Future<T?> showExitDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = Constants.blurSigmaX,
  double blurSigmaY = Constants.blurSigmaY,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: Constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return AlertDialog(
        insetPadding: EdgeInsets.all(Constants.dialogPadding),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          AppLocalizations.of(context)!.confirmExit,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => exit(0),
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.no,
              style: TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
