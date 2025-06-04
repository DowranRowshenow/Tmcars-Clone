import 'package:flutter/material.dart';

import '../../../components/ripple_container.dart';
import '../../../helper/themes.dart';
import '../../../helper/size_config.dart';

class AllProfilesTab extends StatelessWidget {
  const AllProfilesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      color: appColors.menuBackgroundColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          // Search bar container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Use appColors
              color: appColors.themedSurface,
            ),
            padding: EdgeInsets.all(getProportionateScreenWidth(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: getProportionateScreenWidth(10)),
                Flexible(
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(
                      color: appColors.textThemeColor, // Use appColors
                      fontSize: 18,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: "Gözleg",
                      hintStyle: TextStyle(
                        color: appColors.textHintThemeColor, // Use appColors
                      ),
                    ),
                  ),
                ),
                RippleContainer(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  onTap: () {},
                  borderRadius: 25,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.search,
                    color: appColors.iconThemeColor, // Use appColors
                    size: getProportionateScreenWidth(24),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
          // Refreshable list of profiles
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView(),
            ),
          ),
        ],
      ),
    );
  }
}
