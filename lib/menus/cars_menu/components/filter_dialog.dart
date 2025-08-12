import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/car_query_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

Future<bool?> showFilterDialog({
  required BuildContext context,
  required ValueNotifier<CarQuery> query,
  required TabController tabController,
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
      final List<String> list = <String>[
        appLocalizations.filterPrice,
        appLocalizations.filterPriceDesc,
        appLocalizations.filterYear,
        appLocalizations.filterYearDesc,
        appLocalizations.filterDefault,
      ];
      if (query.value.sort != null && query.value.order != null) {
        if (query.value.sort == "price" && query.value.order == "asc") {
          selected = appLocalizations.filterPrice;
        } else if (query.value.sort == "price" && query.value.order == "desc") {
          selected = appLocalizations.filterPriceDesc;
        } else if (query.value.sort == "year" && query.value.order == "desc") {
          selected = appLocalizations.filterYear;
        } else if (query.value.sort == "year" && query.value.order == "asc") {
          selected = appLocalizations.filterYearDesc;
        }
      }

      void setQuery() {
        carQuery = query.value.copyWith();

        if (selected == appLocalizations.filterPrice) {
          carQuery.sort = "price";
          carQuery.order = "asc";
        } else if (selected == appLocalizations.filterPriceDesc) {
          carQuery.sort = "price";
          carQuery.order = "desc";
        } else if (selected == appLocalizations.filterYear) {
          carQuery.sort = "year";
          carQuery.order = "desc";
        } else if (selected == appLocalizations.filterYearDesc) {
          carQuery.sort = "year";
          carQuery.order = "asc";
        } else if (selected == appLocalizations.filterDefault) {
          carQuery.sort = null;
          carQuery.order = null;
        }
        query.value = carQuery.copyWith();
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
              setQuery();
              tabController.animateTo(0);
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
