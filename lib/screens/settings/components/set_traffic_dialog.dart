import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';

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
      int selectedTrafficMode = context.watch<TrafficManager>().getTrafficMode;
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          AppLocalizations.of(context)!.selectLanguage,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListView(
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
              );
            },
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.select,
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
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
