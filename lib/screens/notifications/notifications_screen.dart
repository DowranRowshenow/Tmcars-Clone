import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.notifications),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: Constants.splashRadius,
          splashColor: Colors.transparent,
        ),
      ),
      body: const SingleChildScrollView(child: SizedBox()),
    );
  }
}
