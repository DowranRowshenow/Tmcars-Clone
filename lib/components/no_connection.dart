import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        splashColor: Colors.transparent,
        focusColor: Colors.black12,
        hoverColor: Colors.black12,
        highlightColor: Colors.black12,
        onTap: onTap,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.wifi_off, size: 50),
              const SizedBox(height: 10),
              Text(
                appLocalizations.noInternet,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.refresh, size: 16),
                  Text(appLocalizations.tryAgain),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
