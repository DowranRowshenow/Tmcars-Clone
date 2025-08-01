import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/back_icon_button.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/location.dart';
import '../../providers/navigation.dart';
import '../../providers/themes.dart';
import '../../providers/traffic.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';
import 'components/set_language_dialog.dart';
import 'components/set_location_dialog.dart';
import 'components/set_traffic_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final NavigationManager navigationManager = context
        .read<NavigationManager>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          appLocalizations.settings,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        leading: buildBackIconButton(context),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              appLocalizations.generalSettings,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            tileColor: appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(
              appLocalizations.language,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              appLocalizations.lang,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
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
              appLocalizations.version,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              Constants.packageVersion,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
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
              appLocalizations.internet,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              context.watch<TrafficManager>().isStandart()
                  ? appLocalizations.standard
                  : appLocalizations.econom,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              showSetTrafficDialog(context: context);
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
              appLocalizations.selectedLocation,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              LocationManager.getLocalizedLocation(context),
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              showSetLocationDialog(context: context);
            },
          ),
          ListTile(
            title: Text(
              appLocalizations.additional,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            tileColor: appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(
              appLocalizations.share,
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
                  text: '${appLocalizations.shareText}: ${Server.SHARE_LINK}',
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
              appLocalizations.helper,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              appLocalizations.mustRead,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.ABOUT_US_URL,
                title: appLocalizations.helper,
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
              appLocalizations.policy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              appLocalizations.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: appLocalizations.policy,
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
              appLocalizations.privacyPolicy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              appLocalizations.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: appLocalizations.privacyPolicy,
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
              appLocalizations.commentPolicy,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Text(
              appLocalizations.read,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: appColors.text2ThemeColor,
              ),
            ),
            onTap: () {
              navigationManager.setScreen(
                context,
                ScreenState.webview,
                url: Server.COMMENT_POST_POLICY_URL,
                title: appLocalizations.commentPolicy,
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
              appLocalizations.contact,
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
