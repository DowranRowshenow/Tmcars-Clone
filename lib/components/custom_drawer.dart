import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/navigation.dart';
import '../providers/themes.dart';
import '../utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.onTap});
  final void Function(MenuState) onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final ThemeManager themeManager = context.watch<ThemeManager>();
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Drawer(
      width: 270,
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: appColors.themedSurface,
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Image(
                  image: themeManager.isDark()
                      ? const AssetImage(Constants.drawerLogoDark)
                      : const AssetImage(Constants.drawerLogoLight),
                  height: 60,
                ),
                GestureDetector(
                  child: Text(
                    appLocalizations.login.toUpperCase(),
                    style: const TextStyle(
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
                const SizedBox(height: 20),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.home),
            title: Text(appLocalizations.home),
            leading: const Icon(Icons.home_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.cars),
            title: Text(appLocalizations.cars),
            leading: const Icon(Icons.car_repair_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.parts),
            title: Text(appLocalizations.parts),
            leading: const Icon(Icons.car_rental_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.others),
            title: Text(appLocalizations.others),
            leading: const Icon(Icons.shopping_basket_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.profiles),
            title: Text(appLocalizations.profiles),
            leading: const Icon(Icons.star_border_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.articles),
            title: Text(appLocalizations.news),
            leading: const Icon(Icons.newspaper_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.add),
            title: Text(appLocalizations.add),
            leading: const Icon(Icons.add_box_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => onTap(MenuState.comments),
            title: Text(appLocalizations.comments),
            leading: const Icon(Icons.message_outlined),
            selectedTileColor: Constants.colorPrimary.withAlpha(50),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.3, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            title: Text(
              themeManager.isDark()
                  ? appLocalizations.darkTheme
                  : appLocalizations.lightTheme,
              overflow: TextOverflow.ellipsis,
            ),
            leading: themeManager.isDark()
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined),
            trailing: Switch(
              value: themeManager.isDark(),
              activeColor: appColors.focusColor,
              onChanged: (value) => context.read<ThemeManager>().toggleTheme(),
            ),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => context.read<NavigationManager>().setScreen(
              context,
              ScreenState.settings,
            ),
            title: Text(appLocalizations.settings),
            leading: const Icon(Icons.settings_outlined),
          ),
          ListTile(
            minLeadingWidth: Constants.drawerLeadingWidth,
            contentPadding: Constants.drawerItemPadding,
            onTap: () => context.read<NavigationManager>().setScreen(
              context,
              ScreenState.contact,
            ),
            title: Text(appLocalizations.contactUs),
            leading: const Icon(Icons.support_agent_outlined),
          ),
        ],
      ),
    );
  }
}
