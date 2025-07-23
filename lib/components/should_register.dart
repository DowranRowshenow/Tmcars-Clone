import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/constants.dart';
import '../utils/navigation.dart';

class ShouldRegister extends StatelessWidget {
  const ShouldRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.shouldRegister,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(overflow: TextOverflow.clip, fontSize: 18),
            ),
            SizedBox(height: 10),
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
                AppLocalizations.of(context)!.register.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
