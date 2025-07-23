import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/constants.dart';
import '../utils/navigation.dart';
import '../utils/themes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onTap});
  final void Function(MenuState) onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final ThemeManager themeManager = context.watch<ThemeManager>();

    return Drawer(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: appColors.themedSurface, // Use appColors
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image(
                  image: themeManager.isDark()
                      ? const AssetImage(Constants.drawerLogoDark)
                      : const AssetImage(Constants.drawerLogoLight),
                  height: 60,
                ),
                GestureDetector(
                  child: Text(
                    AppLocalizations.of(context)!.login.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => context.read<NavigationManager>().setScreen(
                    context,
                    ScreenState.register,
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
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
          ),
          ListTile(
            onTap: () => onTap(MenuState.home),
            title: Text(AppLocalizations.of(context)!.home),
            leading: const Icon(Icons.home_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.cars),
            title: Text(AppLocalizations.of(context)!.cars),
            leading: const Icon(Icons.car_repair_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.parts),
            title: Text(AppLocalizations.of(context)!.parts),
            leading: const Icon(Icons.car_rental_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.others),
            title: Text(AppLocalizations.of(context)!.others),
            leading: const Icon(Icons.shopping_basket_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.profiles),
            title: Text(AppLocalizations.of(context)!.profiles),
            leading: const Icon(Icons.star_border_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.articles),
            title: Text(AppLocalizations.of(context)!.news),
            leading: const Icon(Icons.newspaper_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.add),
            title: Text(AppLocalizations.of(context)!.add),
            leading: const Icon(Icons.add_box_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            onTap: () => onTap(MenuState.comments),
            title: Text(AppLocalizations.of(context)!.comments),
            leading: const Icon(Icons.message_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.3, color: Colors.grey),
              ),
            ),
          ),
          ListTile(
            title: Text(
              themeManager.isDark()
                  ? AppLocalizations.of(context)!.darkTheme
                  : AppLocalizations.of(context)!.lightTheme,
              overflow: TextOverflow.ellipsis,
            ),
            leading: themeManager.isDark()
                ? Icon(Icons.dark_mode_outlined)
                : Icon(Icons.light_mode_outlined),
            trailing: Switch(
              value: themeManager.isDark(),
              activeColor: Colors.lightBlueAccent,
              onChanged: (value) => context.read<ThemeManager>().toggleTheme(),
            ),
          ),
          ListTile(
            onTap: () => context.read<NavigationManager>().setScreen(
              context,
              ScreenState.settings,
            ),
            title: Text(
              AppLocalizations.of(context)!.settings,
            ), // Use appColors
            leading: Icon(Icons.settings_outlined),
          ),
          ListTile(
            onTap: () => context.read<NavigationManager>().setScreen(
              context,
              ScreenState.contact,
            ),
            title: Text(
              AppLocalizations.of(context)!.contactUs,
            ), // Use appColors
            leading: Icon(Icons.support_agent_outlined),
          ),
        ],
      ),
    );
  }
}
