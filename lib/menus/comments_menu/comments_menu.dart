import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/constants.dart';
import 'tabs/comments_tab.dart';
import 'tabs/my_comments_tab.dart';

class CommentsMenu extends StatelessWidget {
  const CommentsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: const SizedBox(),
          bottom: TabBar(
            textScaler: const TextScaler.linear(Constants.tabTextScale),
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: appLocalizations.myComments.toUpperCase()),
              Tab(text: appLocalizations.writtenToMe.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(children: [CommentsTab(), MyCommentsTab()]),
      ),
    );
  }
}
