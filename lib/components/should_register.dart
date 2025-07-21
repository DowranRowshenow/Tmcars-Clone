import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../helper/constants.dart' as constants;

class ShouldRegister extends StatefulWidget {
  const ShouldRegister({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShouldRegisterState createState() => _ShouldRegisterState();
}

class _ShouldRegisterState extends State<ShouldRegister> {
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
                  constants.colorPrimary,
                ),
              ),
              onPressed: () {
                constants.navigate.changeScreen(
                  context,
                  constants.ScreenState.register,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.register.toUpperCase(),
                style: TextStyle(color: constants.appColors.textThemeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
