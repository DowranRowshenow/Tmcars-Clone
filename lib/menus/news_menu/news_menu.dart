import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'tabs/news_tab.dart';

class NewsMenu extends StatefulWidget {
  const NewsMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsMenuState createState() => _NewsMenuState();
}

class _NewsMenuState extends State<NewsMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          leading: Container(),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: AppLocalizations.of(context)!.all.toUpperCase())],
          ),
        ),
        body: const TabBarView(children: [NewsTab()]),
      ),
    );
  }
}
