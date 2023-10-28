import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmcars/constants.dart';

import '../../components/back_icon_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
        title: const Text("Sazlamalar"),
        elevation: 0,
        leading: const BackIconButton(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Umumy sazlamalar",
              style: TextStyle(color: themeManager.text2Color()),
            ),
            tileColor: themeManager.tileColor(),
          ),
          ListTile(
            title: Text(
              "Dil",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("Türkmençe"),
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
              "Wersiýa",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("0.1.0"),
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
              style: TextStyle(color: themeManager.textColor()),
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
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("Saýlanmadyk"),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Goşmaça",
              style: TextStyle(color: themeManager.text2Color()),
            ),
            tileColor: themeManager.tileColor(),
          ),
          ListTile(
            title: Text(
              "Paýlaşmak",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              color: Colors.grey,
              width: 6,
            ),
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
              "Kömekçi",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("Okamak maslahat berilýär"),
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
              "Düzgünnama",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("Okap tanyş"),
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
              "Teswir ýazmak ylalaşygy",
              style: TextStyle(color: themeManager.textColor()),
            ),
            trailing: const Text("Okap tanyş"),
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
              "Habarlaşmak üçin",
              style: TextStyle(color: themeManager.textColor()),
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
