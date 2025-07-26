import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tmcarsclone/providers/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../providers/traffic.dart';
import 'components/set_traffic_dialog.dart';
import 'components/set_language_dialog.dart';
import 'components/set_location_dialog.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String getLocation(String location) {
    switch (location) {
      case '':
        return AppLocalizations.of(context)!.notSelected;
      case 'ashgabat':
        return AppLocalizations.of(context)!.ashgabat;
      case 'arkadag':
        return AppLocalizations.of(context)!.arkadag;
      case 'ahal':
        return AppLocalizations.of(context)!.ahal;
      case 'balkan':
        return AppLocalizations.of(context)!.balkan;
      case 'mary':
        return AppLocalizations.of(context)!.mary;
      case 'dashoguz':
        return AppLocalizations.of(context)!.dashoguz;
      case 'lebap':
        return AppLocalizations.of(context)!.lebap;
    }
    return AppLocalizations.of(context)!.notSelected;
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final NavigationManager navigationManager = context
        .read<NavigationManager>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: Constants.splashRadius,
          splashColor: Colors.transparent,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.generalSettings,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            tileColor: appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.language,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              AppLocalizations.of(context)!.lang,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () => showSetLanguageDialog(context: context),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.version,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: const Text(
              Constants.packageVersion,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.internet,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              context.watch<TrafficManager>().getTrafficMode == 0
                  ? AppLocalizations.of(context)!.standard
                  : AppLocalizations.of(context)!.econom,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              showSetTrafficDialog(context: context).then((onValue) {
                setState(() {});
              });
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.selectedLocation,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              getLocation(context.watch<LocationManager>().location),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              showSetLocationDialog(context: context).then((onValue) {
                setState(() {});
              });
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.additional,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            tileColor: appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.share,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: SvgPicture.asset(
              Constants.arrowRight,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              width: 6,
            ),
            onTap: () {
              SharePlus.instance.share(
                ShareParams(
                  text:
                      '${AppLocalizations.of(context)!.shareText}: ${Server.SHARE_LINK}',
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.helper,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              AppLocalizations.of(context)!.mustRead,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.ABOUT_US_URL,
                title: AppLocalizations.of(context)!.helper,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.policy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              AppLocalizations.of(context)!.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: AppLocalizations.of(context)!.policy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.privacyPolicy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              AppLocalizations.of(context)!.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: AppLocalizations.of(context)!.privacyPolicy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.commentPolicy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              AppLocalizations.of(context)!.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.COMMENT_POST_POLICY_URL,
                title: AppLocalizations.of(context)!.commentPolicy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.contact,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: SvgPicture.asset(
              Constants.arrowRight,
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              width: 6,
            ),
            onTap: () {
              launchUrl(Uri.parse(Server.CONTACT_URL));
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: appColors.dividerColor!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
