import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/navigation.dart';
import '../providers/themes.dart';
import '../utils/constants.dart';

class ShouldRegister extends StatelessWidget {
  const ShouldRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations.shouldRegister,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(overflow: TextOverflow.clip, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(appColors.focusColor),
                backgroundColor: WidgetStateProperty.all(
                  Constants.colorPrimary,
                ),
              ),
              onPressed: () {
                context.read<NavigationManager>().setScreen(
                  context,
                  ScreenState.register,
                );
              },
              child: Text(
                appLocalizations.register.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
