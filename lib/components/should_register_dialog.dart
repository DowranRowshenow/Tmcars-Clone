import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../l10n/app_localizations.dart';
import '../providers/navigation.dart';
import '../providers/themes.dart';

Future<T?> shouldRegisterDialog<T>({
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
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        title: Text(
          AppLocalizations.of(context)!.notification,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: Text(AppLocalizations.of(context)!.notRegistered),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.register.toUpperCase(),
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
              context.read<NavigationManager>().setScreen(
                context,
                ScreenState.register,
              );
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
            ),
            child: Text(
              AppLocalizations.of(context)!.cancel.toUpperCase(),
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      );
    },
  );
}
