//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/navigation.dart';
import '../providers/themes.dart';
import '../utils/constants.dart';

Future<bool?> shouldRegisterDialog({
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

      return PopScope(
        canPop: barrierDismissible,
        child: AlertDialog(
          insetPadding: const EdgeInsets.all(Constants.dialogPadding),
          backgroundColor: appColors.themedSurface,
          elevation: Constants.elevation,
          contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          title: Text(
            localizations.notification,
            style: TextStyle(color: appColors.textThemeColor),
          ),
          content: SizedBox(
            width: Constants.dialogWidth,
            child: Text(localizations.notRegistered),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
                context.read<NavigationManager>().setScreen(
                  dialogContext,
                  ScreenState.register,
                );
              },
              child: Text(
                localizations.register.toUpperCase(),
                style: const TextStyle(color: Constants.colorPrimary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                localizations.cancel.toUpperCase(),
                style: const TextStyle(color: Constants.colorPrimary),
              ),
            ),
          ],
        ),
      );
    },
  );
}
