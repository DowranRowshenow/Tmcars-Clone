import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/location.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

Future<bool?> showSetLocationDialog({
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
      final AppColors appColors = Theme.of(context).extension<AppColors>()!;
      final AppLocalizations appLocalizations =
          Localizations.of<AppLocalizations>(context, AppLocalizations)!;
      final LocationManager location = context.read<LocationManager>();
      const double padding = 30;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.only(top: 20),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          appLocalizations.selectedLocation,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: Constants.dialogWidth,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.notSelected),
                onTap: () {
                  location.setLocation(Location.none);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.ashgabat),
                onTap: () {
                  location.setLocation(Location.ashgabat);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.arkadag),
                onTap: () {
                  location.setLocation(Location.arkadag);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.ahal),
                onTap: () {
                  location.setLocation(Location.ahal);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.balkan),
                onTap: () {
                  location.setLocation(Location.balkan);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.mary),
                onTap: () {
                  location.setLocation(Location.mary);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.dashoguz),
                onTap: () {
                  location.setLocation(Location.dashoguz);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: padding),
                title: Text(appLocalizations.lebap),
                onTap: () {
                  location.setLocation(Location.lebap);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
