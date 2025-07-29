import 'package:flutter/material.dart';

import '../../components/back_icon_button.dart';
import '../../l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.notifications),
        leading: buildBackIconButton(context),
      ),
      body: const SingleChildScrollView(child: SizedBox()),
    );
  }
}
