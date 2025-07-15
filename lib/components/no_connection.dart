import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
            children: [
              const Icon(Icons.wifi_off, size: 50),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.noInternet,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.refresh, size: 16),
                  Text(AppLocalizations.of(context)!.tryAgain),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
