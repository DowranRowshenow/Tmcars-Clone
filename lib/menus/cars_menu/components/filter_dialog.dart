import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/car_query_model.dart';
import '../../../providers/themes.dart';
import '../../../utils/constants.dart';

Future<bool?> showFilterDialog({
  required BuildContext context,
  required ValueNotifier<CarQuery>? query,
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
      CarQuery carQuery = CarQuery();
      String selected = appLocalizations.filterDefault;
      if (query != null) {
        selected = query.value.sort ?? selected;
      }

      return AlertDialog(
        insetPadding: const EdgeInsets.all(Constants.dialogPadding),
        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        backgroundColor: appColors.themedSurface,
        elevation: Constants.elevation,
        title: Text(
          appLocalizations.filterSelect,
          style: TextStyle(color: appColors.textThemeColor),
        ),
        content: SizedBox(
          width: Constants.dialogWidth,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              final List<String> list = <String>[
                appLocalizations.filterPrice,
                appLocalizations.filterPriceDesc,
                appLocalizations.filterYear,
                appLocalizations.filterYearDesc,
                appLocalizations.filterDefault,
              ];
              return ListView(
                shrinkWrap: true,
                children: list.map((String translations) {
                  return RadioListTile<bool>(
                    title: Text(translations),
                    value: true,
                    groupValue: selected == translations,
                    onChanged: (bool? value) {
                      if (context.mounted) {
                        setState(() {
                          selected = translations;
                          if (translations == appLocalizations.filterPrice) {
                            carQuery.sort = "price";
                            carQuery.order = "asc";
                          } else if (translations ==
                              appLocalizations.filterPriceDesc) {
                            carQuery.sort = "price";
                            carQuery.order = "desc";
                          } else if (translations ==
                              appLocalizations.filterYear) {
                            carQuery.sort = "year";
                            carQuery.order = "asc";
                          } else if (translations ==
                              appLocalizations.filterPrice) {
                            carQuery.sort = "year";
                            carQuery.order = "desc";
                          } else if (translations ==
                              appLocalizations.filterDefault) {
                            carQuery = CarQuery();
                          }
                        });
                      }
                    },
                    activeColor: Constants.colorPrimary,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                }).toList(),
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              appLocalizations.select,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () {
              query?.value = carQuery;
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(color: Constants.colorPrimary),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      );
    },
  );
}
