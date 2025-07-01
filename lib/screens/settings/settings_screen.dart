import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:share_plus/share_plus.dart';

import '../../components/select_language_dialog.dart';
import '../../helper/constants.dart' as constants;
import '../../helper/server.dart';
import '../../helper/strings.dart';

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
        title: const Text(Localization.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(Localization.generalSettings),
            tileColor: constants.appColors.tileThemeColor,
            onTap: () {},
          ),
          ListTile(
            title: Text(Localization.language),
            trailing: const Text(Localization.turkmen),
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
            title: Text(Localization.version),
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
            title: Text(Localization.internet),
            trailing: const Text(Localization.standard),
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
            title: Text(Localization.selectedLocation),
            trailing: const Text(Localization.notSelected),
            onTap: () {},
          ),
          ListTile(
            title: Text(Localization.additional),
            tileColor: constants.appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(Localization.share),
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
            title: Text(Localization.helper),
            trailing: const Text(Localization.mustRead),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.ABOUT_US_URL,
                title: Localization.helper,
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
            title: Text(Localization.policy),
            trailing: const Text(Localization.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: Localization.policy,
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
            title: Text(Localization.privacyPolicy),
            trailing: const Text(Localization.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: Localization.privacyPolicy,
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
            title: Text(Localization.commentPolicy),
            trailing: const Text(Localization.read),
            onTap: () {
              constants.navigate.changeScreen(
                context,
                constants.ScreenState.webview,
                url: Server.COMMENT_POST_POLICY_URL,
                title: Localization.commentPolicy,
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
            title: Text(Localization.contact),
            trailing: const Text(Localization.email),
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
