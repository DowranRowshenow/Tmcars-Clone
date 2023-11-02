import 'dart:io';

import 'package:flutter/material.dart';

import '../../components/custom_drawer.dart';
import '../../components/menu_icon_button.dart';
import '../../helper/constants.dart';
import '../../helper/size_config.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Çykmak isleýärsiňizmi?"),
              actions: [
                TextButton(
                  child: const Text("Hawa"),
                  onPressed: () {
                    exit(0);
                  },
                ),
                TextButton(
                  child: const Text("Ýok"),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(
          title: Text(navigate.getMenuTitle()),
          leading: const MenuIconButton(),
          actions: [
            navigate.currentMenu == MenuState.others
                ? IconButton(
                    onPressed: () {},
                    splashRadius: splashRadius,
                    icon: const Icon(Icons.sort),
                  )
                : Container(),
            navigate.currentMenu == MenuState.others
                ? IconButton(
                    onPressed: () {},
                    splashRadius: splashRadius,
                    icon: const Icon(Icons.star),
                  )
                : Container(),
          ],
        ),
        drawer: CustomDrawer(
          onTap: (state) {
            setState(() {
              scaffold.currentState!.closeDrawer();
              navigate.currentMenu = state;
            });
          },
        ),
        body: navigate.getCurrentMenu(),
      ),
    );
  }
}
