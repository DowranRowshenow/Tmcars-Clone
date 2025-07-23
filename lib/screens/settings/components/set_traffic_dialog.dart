import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';

Future<T?> showSetTrafficDialog<T>({
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
      int selectedTrafficMode = context.watch<TrafficManager>().getTrafficMode;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(Constants.dialogPadding),
            contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            backgroundColor: appColors.themedSurface,
            elevation: Constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  RadioListTile<int>(
                    title: Text(AppLocalizations.of(context)!.standard),
                    value: 0,
                    groupValue: selectedTrafficMode,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTrafficMode = 0;
                      });
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  RadioListTile<int>(
                    title: Text(AppLocalizations.of(context)!.econom),
                    value: 1,
                    groupValue: selectedTrafficMode,
                    onChanged: (int? value) {
                      setState(() {
                        selectedTrafficMode = 1;
                      });
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.select,
                  style: TextStyle(color: Constants.colorPrimary),
                ),
                onPressed: () {
                  context.read<TrafficManager>().setTrafficMode(
                    selectedTrafficMode,
                  );
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(color: Constants.colorPrimary),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    },
  );
}
