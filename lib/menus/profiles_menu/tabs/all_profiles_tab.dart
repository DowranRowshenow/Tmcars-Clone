import 'package:flutter/material.dart';

import '../../../components/ripple_container.dart';
import '../../../helper/constants.dart' as constants;
import '../../../helper/strings.dart';

class AllProfilesTab extends StatelessWidget {
  const AllProfilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: constants.appColors.menuBackgroundColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          // Search bar container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Use appColors
              color: constants.appColors.themedSurface,
            ),
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: Localization.search,
                    ),
                  ),
                ),
                RippleContainer(
                  padding: EdgeInsets.all(10),
                  onTap: () {},
                  borderRadius: 25,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.search,
                    color: constants.appColors.iconThemeColor, // Use appColors
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          // Refreshable list of profiles
          Expanded(
            child: RefreshIndicator(onRefresh: () async {}, child: ListView()),
          ),
        ],
      ),
    );
  }
}
