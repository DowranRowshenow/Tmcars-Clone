import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:share_plus/share_plus.dart';

import '../../components/back_icon_button.dart';
import '../../helper/constants.dart';
import '../../helper/server.dart';
import '../../helper/themes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Sazlamalar"),
        leading: const BackIconButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Umumy sazlamalar",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            tileColor: appColors.tileThemeColor,
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Dil",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Türkmençe"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Dil saýla"),
                    actions: [
                      TextButton(
                        child: const Text("Saýla"),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Wersiýa",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text(packageVersion),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Internet",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Standart"),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Saýlanan ýer",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Saýlanmadyk"),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Goşmaça",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            tileColor: appColors.tileThemeColor,
          ),
          ListTile(
            title: Text(
              "Paýlaşmak",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              color: Colors.grey,
              width: 6,
            ),
            onTap: () {
              // You can customize the text and link you want to share.
              // For example, a link to your app on the app stores or your website.
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
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Kömekçi",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Okamak maslahat berilýär"),
            onTap: () {
              navigate.changeScreen(
                context,
                ScreenState.webview,
                url: Server.ABOUT_US_URL,
                title: 'Kömekçi',
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Düzgünnama",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Okap tanyş"),
            onTap: () {
              navigate.changeScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: 'Düzgünnama',
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Gizlinlik syýasaty",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Okap tanyş"),
            onTap: () {
              navigate.changeScreen(
                context,
                ScreenState.webview,
                url: Server.PRIVACY_POLICY_URL,
                title: 'Gizlinlik syýasaty',
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Teswir ýazmak ylalaşygy",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("Okap tanyş"),
            onTap: () {
              navigate.changeScreen(
                context,
                ScreenState.webview,
                url: Server.COMMENT_POST_POLICY_URL,
                title: 'Teswir ýazmak ylalaşygy',
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Habarlaşmak üçin",
              style: TextStyle(color: appColors.textThemeColor),
            ),
            trailing: const Text("dowranrowshenow@gmail.com"),
            onTap: () {},
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: themeManager.isDark()
                      ? Colors.white.withOpacity(0.5)
                      : Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
