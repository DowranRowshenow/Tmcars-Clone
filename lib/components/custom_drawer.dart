import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/size_config.dart';
import '../helper/themes.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Drawer(
      width: getProportionateScreenWidth(260),
      backgroundColor: appColors.themedSurface, // Use appColors
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenWidth(20)),
                Image(
                  image: Theme.of(context).brightness ==
                          Brightness.dark // Use Theme.of(context).brightness
                      ? const AssetImage('assets/images/drawer_logo_dark.webp')
                      : const AssetImage(
                          'assets/images/drawer_logo_light.webp'),
                  height: getProportionateScreenHeight(60),
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
                    navigate.changeScreen(context, ScreenState.register);
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
              widget.onTap(MenuState.home);
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
            onTap: () {
              widget.onTap(MenuState.others);
            },
            title: const Text("Beýleki bildirişler"),
            leading: const Icon(Icons.shopping_basket_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              widget.onTap(MenuState.profiles);
            },
            title: const Text("Biznez hasaplar"),
            leading: const Icon(Icons.star_border_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              widget.onTap(MenuState.news);
            },
            title: const Text("Habarlar"),
            leading: const Icon(Icons.newspaper_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              widget.onTap(MenuState.add);
            },
            title: const Text("Bildiriş goşmak"),
            leading: const Icon(Icons.add_box_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              widget.onTap(MenuState.comments);
            },
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
                ? Text("Gara tema",
                    style: TextStyle(
                        color: appColors.textThemeColor)) // Use appColors
                : Text("Ýagty tema",
                    style: TextStyle(
                        color: appColors.textThemeColor)), // Use appColors
            leading: themeManager.isDark()
                ? Icon(Icons.dark_mode_outlined,
                    color: appColors.iconThemeColor)
                : Icon(Icons.light_mode_outlined,
                    color: appColors.iconThemeColor), // Use appColors
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
              navigate.changeScreen(context, ScreenState.settings);
            },
            title: Text("Sazlamalar",
                style: TextStyle(
                    color: appColors.textThemeColor)), // Use appColors
            leading: Icon(Icons.settings_outlined,
                color: appColors.iconThemeColor), // Use appColors
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () {
              navigate.changeScreen(context, ScreenState.contact);
            },
            title: Text("Habarlaşmak",
                style: TextStyle(
                    color: appColors.textThemeColor)), // Use appColors
            leading: Icon(Icons.support_agent_outlined,
                color: appColors.iconThemeColor), // Use appColors
            selectedTileColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}
