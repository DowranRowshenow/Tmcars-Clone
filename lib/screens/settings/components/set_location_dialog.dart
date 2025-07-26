import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/location.dart';
import '../../../providers/themes.dart';

Future<T?> showSetLocationDialog<T>({
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

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(Constants.dialogPadding),
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            backgroundColor: appColors.themedSurface,
            elevation: Constants.elevation,
            title: Text(
              AppLocalizations.of(context)!.selectedLocation,
              style: TextStyle(color: appColors.textThemeColor),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.notSelected),
                    onTap: () {
                      context.read<LocationManager>().setLocation('');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ashgabat),
                    onTap: () {
                      context.read<LocationManager>().setLocation('ashgabat');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.arkadag),
                    onTap: () {
                      context.read<LocationManager>().setLocation('arkadag');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.ahal),
                    onTap: () {
                      context.read<LocationManager>().setLocation('ahal');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.balkan),
                    onTap: () {
                      context.read<LocationManager>().setLocation('balkan');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.mary),
                    onTap: () {
                      context.read<LocationManager>().setLocation('mary');
                      Navigator.of(context).pop();
                    },
                  ),

                  ListTile(
                    title: Text(AppLocalizations.of(context)!.dashoguz),
                    onTap: () {
                      context.read<LocationManager>().setLocation('dashoguz');
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.lebap),
                    onTap: () {
                      context.read<LocationManager>().setLocation('lebap');
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
                  style: const TextStyle(color: Constants.colorPrimary),
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
