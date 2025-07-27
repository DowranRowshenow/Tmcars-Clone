import 'dart:io';

import 'package:flutter/material.dart';

import '../providers/themes.dart';
import '../utils/constants.dart';
import '../l10n/app_localizations.dart';

Future<bool?> showExitDialog({
  required BuildContext context,
  Color? barrierColor,
  bool barrierDismissible = true,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor:
        barrierColor ?? Colors.black.withValues(alpha: Constants.blurAlpha),
    builder: (BuildContext dialogContext) {
      final AppColors appColors = Theme.of(
        dialogContext,
      ).extension<AppColors>()!;
      final AppLocalizations localizations = AppLocalizations.of(
        dialogContext,
      )!;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          localizations.confirmExit,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        actions: [
          TextButton(
            child: Text(
              localizations.yes,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => exit(0),
          ),
          TextButton(
            child: Text(
              localizations.no,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
