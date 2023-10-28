import 'dart:io';

import 'package:flutter/material.dart';

import '../../components/custom_drawer.dart';
import '../../components/menu_icon_button.dart';
import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreentate();
}

class _HomeScreentate extends State<HomeScreen> {
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
        appBar: AppBar(
          title: const Text("Baş Sahypa"),
          elevation: 0,
          leading: const MenuIconButton(),
        ),
        drawer: const CustomDrawer(),
        body: Container(),
      ),
    );
  }
}
