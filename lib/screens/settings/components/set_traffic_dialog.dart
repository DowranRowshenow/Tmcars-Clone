import 'package:flutter/material.dart';

import '../../../utils/storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart' as constants;
import 'traffic_option.dart';

Future<T?> showSetTrafficDialog<T>({
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
      int selectedTrafficMode = constants.trafficMode;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(constants.dialogPadding),
            contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            backgroundColor: constants.appColors.themedSurface,
            elevation: constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(color: constants.appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TrafficOption(
                    text: AppLocalizations.of(context)!.standard,
                    value: 0,
                    selectedValue: constants.trafficMode,
                    onTap: () {
                      setState(() {
                        constants.trafficMode = 0;
                      });
                    },
                  ),
                  TrafficOption(
                    text: AppLocalizations.of(context)!.econom,
                    value: 1,
                    selectedValue: constants.trafficMode,
                    onTap: () {
                      setState(() {
                        constants.trafficMode = 1;
                      });
                    },
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
                  style: TextStyle(color: constants.colorPrimary),
                ),
                onPressed: () {
                  Storage().setTrafficMode(selectedTrafficMode);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: InkSparkle.splashFactory,
                ),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(color: constants.colorPrimary),
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
