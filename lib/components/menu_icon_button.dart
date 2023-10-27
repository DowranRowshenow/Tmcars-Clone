import 'package:flutter/material.dart';

import '../constants.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      splashRadius: splashRadius,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
