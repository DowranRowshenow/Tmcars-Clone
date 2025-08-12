import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

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
      final AppLocalizations appLocalizations =
          Localizations.of<AppLocalizations>(dialogContext, AppLocalizations)!;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          appLocalizations.confirmExit,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              appLocalizations.yes,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => SystemNavigator.pop(),
          ),
          TextButton(
            child: Text(
              appLocalizations.no,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
