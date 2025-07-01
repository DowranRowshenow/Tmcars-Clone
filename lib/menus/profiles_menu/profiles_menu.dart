import 'package:flutter/material.dart';

import '../../helper/strings.dart';
import 'tabs/all_profiles_tab.dart';
import 'tabs/profiles_category_tab.dart';

class ProfilesMenu extends StatefulWidget {
  const ProfilesMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilesMenuState createState() => _ProfilesMenuState();
}

class _ProfilesMenuState extends State<ProfilesMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: Container(),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: Localization.all.toUpperCase()),
              Tab(text: Localization.category.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [AllProfilesTab(), ProfilesCategoryTab()],
        ),
      ),
    );
  }
}
