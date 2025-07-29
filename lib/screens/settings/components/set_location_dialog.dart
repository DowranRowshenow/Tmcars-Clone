import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../providers/location.dart';
import '../../../providers/themes.dart';

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
      final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          appLocalizations.selectedLocation,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(appLocalizations.notSelected),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.none);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.ashgabat),
                onTap: () {
                  context.read<LocationManager>().setLocation(
                    Location.ashgabat,
                  );
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.arkadag),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.arkadag);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.ahal),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.ahal);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.balkan),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.balkan);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.mary),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.mary);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.dashoguz),
                onTap: () {
                  context.read<LocationManager>().setLocation(
                    Location.dashoguz,
                  );
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text(appLocalizations.lebap),
                onTap: () {
                  context.read<LocationManager>().setLocation(Location.lebap);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        actions: [
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
