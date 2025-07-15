import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:share_plus/share_plus.dart';

import '../../components/select_language_dialog.dart';
import '../../helper/constants.dart' as constants;
import '../../helper/server.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
          splashColor: Colors.transparent,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.generalSettings),
            tileColor: constants.appColors.tileThemeColor,
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: Text(AppLocalizations.of(context)!.lang),
            onTap: () => showSelectLanguageDialog(context: context),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.version),
            trailing: const Text(constants.packageVersion),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.internet),
            trailing: Text(AppLocalizations.of(context)!.standard),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.selectedLocation),
            trailing: Text(AppLocalizations.of(context)!.notSelected),
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.additional),
            tileColor: constants.appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.share),
            trailing: SvgPicture.asset(
              constants.arrowRight,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              width: 6,
            ),
            onTap: () {
              /*
              Share.share(
                'Check out this awesome app: ${Server.SHARE_LINK}', // Replace with your desired link and message
                subject:
                    'Have a look at TMCARS App!', // Optional: subject for email sharing
              );
              */
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.helper),
            trailing: Text(AppLocalizations.of(context)!.mustRead),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.ABOUT_US_URL,
                title: AppLocalizations.of(context)!.helper,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.policy),
            trailing: Text(AppLocalizations.of(context)!.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: AppLocalizations.of(context)!.policy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.privacyPolicy),
            trailing: Text(AppLocalizations.of(context)!.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: AppLocalizations.of(context)!.privacyPolicy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.commentPolicy),
            trailing: Text(AppLocalizations.of(context)!.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.COMMENT_POST_POLICY_URL,
                title: AppLocalizations.of(context)!.commentPolicy,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.contact),
            trailing: const Text(constants.email),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: constants.appColors.dividerColor!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
