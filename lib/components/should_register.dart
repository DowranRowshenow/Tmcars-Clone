import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/constants.dart';
import '../providers/navigation.dart';

class ShouldRegister extends StatelessWidget {
  const ShouldRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizations.shouldRegister,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(overflow: TextOverflow.clip, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
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
