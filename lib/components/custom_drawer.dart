import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/navigate.dart';
import '../size_config.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getProportionateScreenWidth(260),
      backgroundColor: themeManager.drawerColor(),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(20)),
                Image(
                  image: themeManager.isDark()
                      ? const AssetImage('assets/images/drawer_logo_dark.webp')
                      : const AssetImage(
                          'assets/images/drawer_logo_light.webp'),
                  height: 60,
                ),
                GestureDetector(
                  child: const Text(
                    'ULGAMA GIRMEK',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () {
                    // Navigate to Register Screen
                  },
                ),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigate.changeScreen(context, MenuState.home);
            },
            title: const Text("Baş sahypa"),
            leading: const Icon(Icons.home_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Awtoulaglar"),
            leading: const Icon(Icons.car_repair_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Awtoşaýlar"),
            leading: const Icon(Icons.car_rental_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Beýleki bildirişler"),
            leading: const Icon(Icons.shopping_basket_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Biznez hasaplar"),
            leading: const Icon(Icons.star_border_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Habarlar"),
            leading: const Icon(Icons.newspaper_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Bildiriş goşmak"),
            leading: const Icon(Icons.add_box_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {},
            title: const Text("Teswirler"),
            leading: const Icon(Icons.message_outlined),
            selectedTileColor: Colors.white12,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.3,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            title: themeManager.isDark()
                ? const Text("Gara tema")
                : const Text("Ýagty tema"),
            leading: themeManager.isDark()
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined),
            trailing: Switch(
              value: themeManager.themeMode == ThemeMode.dark,
              activeColor: Colors.lightBlueAccent,
              onChanged: (value) {
                setState(() {
                  themeManager.toggleTheme(value);
                });
              },
            ),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              Navigate.changeScreen(context, MenuState.settings);
            },
            title: const Text("Sazlamalar"),
            leading: const Icon(Icons.settings_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              Navigate.changeScreen(context, MenuState.contact);
            },
            title: const Text("Habarlaşmak"),
            leading: const Icon(Icons.support_agent_outlined),
            selectedTileColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}
