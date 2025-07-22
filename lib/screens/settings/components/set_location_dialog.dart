import 'package:flutter/material.dart';

import '../../../utils/storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart' as constants;

Future<T?> showSetLocationDialog<T>({
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
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(constants.dialogPadding),
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            backgroundColor: constants.appColors.themedSurface,
            elevation: constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectedLocation,
              style: TextStyle(color: constants.appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.notSelected),
                    onTap: () {
                      constants.location = '';
                      Storage().setLocation('');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ashgabat),
                    onTap: () {
                      constants.location = 'ashgabat';
                      Storage().setLocation('ashgabat');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.arkadag),
                    onTap: () {
                      constants.location = 'arkadag';
                      Storage().setLocation('arkadag');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ahal),
                    onTap: () {
                      constants.location = 'ahal';
                      Storage().setLocation('ahal');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.balkan),
                    onTap: () {
                      constants.location = 'balkan';
                      Storage().setLocation('balkan');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.mary),
                    onTap: () {
                      constants.location = 'mary';
                      Storage().setLocation('mary');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dashoguz),
                    onTap: () {
                      constants.location = 'dashoguz';
                      Storage().setLocation('dashoguz');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.lebap),
                    onTap: () {
                      constants.location = 'lebap';
                      Storage().setLocation('lebap');
                      Navigator.of(context).pop();
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
