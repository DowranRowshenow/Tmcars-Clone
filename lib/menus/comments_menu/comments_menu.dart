import 'package:flutter/material.dart';

import '../../helper/strings.dart';
import 'tabs/comments_tab.dart';
import 'tabs/my_comments_tab.dart';

class CommentsMenu extends StatefulWidget {
  const CommentsMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CommentsMenuState createState() => _CommentsMenuState();
}

class _CommentsMenuState extends State<CommentsMenu> {
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
              Tab(text: Localization.myComments.toUpperCase()),
              Tab(text: Localization.writtenToMe.toUpperCase()),
            ],
          ),
        ),
        body: const TabBarView(children: [CommentsTab(), MyCommentsTab()]),
      ),
    );
  }
}
