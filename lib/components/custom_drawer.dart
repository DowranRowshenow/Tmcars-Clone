import 'package:flutter/material.dart';

import '../helper/constants.dart' as constants;
import '../helper/strings.dart';
import '../helper/themes.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.onTap});
  final Function onTap;

  @override
  // ignore: library_private_types_in_public_api
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    constants.appColors = Theme.of(context).extension<AppColors>()!;

    return Drawer(
      width: 260,
      backgroundColor: constants.appColors.themedSurface, // Use appColors
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image(
                  image: constants.themeManager.isDark()
                      ? const AssetImage(constants.drawerLogoDark)
                      : const AssetImage(constants.drawerLogoLight),
                  height: 60,
                ),
                GestureDetector(
                  child: Text(
                    Localization.login.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => constants.navigate.changeScreen(
                    context,
                    constants.ScreenState.register,
                  ),
                ),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.black),
              ),
            ),
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.home),
            title: Text(Localization.home),
            leading: const Icon(Icons.home_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.cars),
            title: Text(Localization.cars),
            leading: const Icon(Icons.car_repair_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.parts),
            title: Text(Localization.parts),
            leading: const Icon(Icons.car_rental_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.others),
            title: Text(Localization.others),
            leading: const Icon(Icons.shopping_basket_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.profiles),
            title: Text(Localization.profiles),
            leading: const Icon(Icons.star_border_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.news),
            title: Text(Localization.news),
            leading: const Icon(Icons.newspaper_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.add),
            title: Text(Localization.add),
            leading: const Icon(Icons.add_box_outlined),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => widget.onTap(constants.MenuState.comments),
            title: Text(Localization.comments),
            leading: const Icon(Icons.message_outlined),
            selectedTileColor: Colors.white12,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.3, color: Colors.black),
              ),
            ),
          ),
          ListTile(
            title: constants.themeManager.isDark()
                ? Text(
                    Localization.darkTheme,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ) // Use appColors
                : Text(
                    Localization.lightTheme,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ), // Use appColors
            leading: constants.themeManager.isDark()
                ? Icon(
                    Icons.dark_mode_outlined,
                    color: constants.appColors.iconThemeColor,
                  )
                : Icon(
                    Icons.light_mode_outlined,
                    color: constants.appColors.iconThemeColor,
                  ), // Use appColors
            trailing: Switch(
              value: constants.themeManager.isDark(),
              activeColor: Colors.lightBlueAccent,
              onChanged: (value) =>
                  setState(() => constants.themeManager.toggleTheme()),
            ),
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => constants.navigate.changeScreen(
              context,
              constants.ScreenState.settings,
            ),
            title: Text(Localization.settings), // Use appColors
            leading: Icon(
              Icons.settings_outlined,
              color: constants.appColors.iconThemeColor,
            ), // Use appColors
            selectedTileColor: Colors.white12,
          ),
          ListTile(
            onTap: () => constants.navigate.changeScreen(
              context,
              constants.ScreenState.contact,
            ),
            title: Text(Localization.contactUs), // Use appColors
            leading: Icon(
              Icons.support_agent_outlined,
              color: constants.appColors.iconThemeColor,
            ), // Use appColors
            selectedTileColor: Colors.white12,
          ),
        ],
      ),
    );
  }
}
