import 'package:flutter/material.dart';

import '../helper/constants.dart' as constants;
import '../l10n/app_localizations.dart';

Future<T?> shouldRegisterDialog<T>({
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
        contentPadding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        title: Text(
          AppLocalizations.of(context)!.notification,
          style: TextStyle(color: constants.appColors.textThemeColor),
        ),
        content: Text(AppLocalizations.of(context)!.notRegistered),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.register.toUpperCase(),
              style: TextStyle(color: constants.colorPrimary),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.register,
              );
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.cancel.toUpperCase(),
              style: TextStyle(color: constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
