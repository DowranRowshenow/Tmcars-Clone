import 'package:flutter/material.dart';

import '../../../components/ripple_container.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/themes.dart';

class AllProfilesTab extends StatelessWidget {
  const AllProfilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      color: appColors.menuBackgroundColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Use appColors
              color: appColors.themedSurface,
            ),
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    autocorrect: false,
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: Localizations.of<AppLocalizations>(
                        context,
                        AppLocalizations,
                      )!.search,
                    ),
                  ),
                ),
                RippleContainer(
                  padding: const EdgeInsets.all(10),
                  onTap: () {},
                  borderRadius: 25,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.search,
                    color: appColors.iconThemeColor, // Use appColors
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: RefreshIndicator(onRefresh: () async {}, child: ListView()),
          ),
        ],
      ),
    );
  }
}
