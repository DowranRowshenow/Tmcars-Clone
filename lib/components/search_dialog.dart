// The import statements remain the same
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import 'minimal_button.dart';

Future<bool?> searchDialog({
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
      final AppLocalizations appLocalizations = AppLocalizations.of(
        dialogContext,
      )!;

      return PopScope(
        canPop: barrierDismissible,
        child: AlertDialog(
          insetPadding: const EdgeInsets.all(Constants.dialogPadding),
          backgroundColor: appColors.themedSurface,
          elevation: Constants.elevation,
          contentPadding: const EdgeInsets.all(20),
          title: Row(
            children: <Widget>[
              const Icon(Icons.info, color: Constants.colorPrimary, size: 28),
              const SizedBox(width: 4),
              Text(
                appLocalizations.searchTypes,
                style: TextStyle(color: appColors.textThemeColor),
              ),
            ],
          ),
          content: SizedBox(
            width: Constants.dialogWidth, // Defines the dialog's width
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Forces the column to shrink vertically
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const MinimalButton(text: '='),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        appLocalizations.searchDialog,
                        softWrap: true,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const MinimalButton(text: '~'),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        appLocalizations.searchDialog2,
                        softWrap: true,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: Constants.dialogWidth,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Constants.colorPrimary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(true);
                    },
                    child: Text(
                      appLocalizations.ok.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
