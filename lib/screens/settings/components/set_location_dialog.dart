import 'package:flutter/material.dart';

import '../../../helper/storage.dart';
import '../../../l10n/app_localizations.dart';
import '../../../helper/constants.dart' as constants;

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
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ashgabat),
                    onTap: () {
                      constants.location = AppLocalizations.of(
                        context,
                      )!.ashgabat;
                      Storage().setLocation('ashgabat');
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.arkadag),
                    onTap: () {
                      constants.location = AppLocalizations.of(
                        context,
                      )!.arkadag;
                      Storage().setLocation('arkadag');
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ahal),
                    onTap: () {
                      constants.location = AppLocalizations.of(context)!.ahal;
                      Storage().setLocation('ahal');
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.balkan),
                    onTap: () {
                      constants.location = AppLocalizations.of(context)!.balkan;
                      Storage().setLocation('balkan');
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.mary),
                    onTap: () {
                      constants.location = AppLocalizations.of(context)!.mary;
                      Storage().setLocation('mary');
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dashoguz),
                    onTap: () {
                      constants.location = AppLocalizations.of(
                        context,
                      )!.dashoguz;
                      Storage().setLocation('dashoguz');
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.lebap),
                    onTap: () {
                      constants.location = AppLocalizations.of(context)!.lebap;
                      Storage().setLocation('lebap');
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
