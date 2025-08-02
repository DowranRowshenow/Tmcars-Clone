import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';
import '../../../utils/constants.dart';

Future<bool?> showSetTrafficDialog({
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
      int selectedTrafficMode = context.read<TrafficManager>().trafficMode;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          Localizations.of<AppLocalizations>(
            context,
            AppLocalizations,
          )!.selectLanguage,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  RadioListTile<int>(
                    title: Text(
                      Localizations.of<AppLocalizations>(
                        context,
                        AppLocalizations,
                      )!.standard,
                    ),
                    value: 0,
                    groupValue: selectedTrafficMode,
                    onChanged: (int? value) {
                      if (context.mounted) {
                        setState(() {
                          selectedTrafficMode = 0;
                        });
                      }
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  RadioListTile<int>(
                    title: Text(
                      Localizations.of<AppLocalizations>(
                        context,
                        AppLocalizations,
                      )!.econom,
                    ),
                    value: 1,
                    groupValue: selectedTrafficMode,
                    onChanged: (int? value) {
                      if (context.mounted) {
                        setState(() {
                          selectedTrafficMode = 1;
                        });
                      }
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              Localizations.of<AppLocalizations>(
                context,
                AppLocalizations,
              )!.select,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () {
              context.read<TrafficManager>().setTrafficMode(
                selectedTrafficMode,
              );
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              Localizations.of<AppLocalizations>(
                context,
                AppLocalizations,
              )!.cancel,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
