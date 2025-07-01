import 'package:flutter/material.dart';

import 'navigate.dart';
import 'themes.dart';

// TEMPORARY
const String tempImageUrl =
    "https://tapgo.biz:8443/tmcars/images/original/2025/04/04/16/45/21ba5856-2f62-4a80-9495-d02f9c376bd6.png";

// APPLICATION
const String packageVersion = '0.2.1';
const String appName = 'Tmcars Clone';

// ICONS
const String arrowRight = 'assets/icons/arrow_right.svg';
const String drawerLogoDark = 'assets/images/drawer_logo_dark.webp';
const String drawerLogoLight = 'assets/images/drawer_logo_light.webp';

// GLOBAL VARIABLAES
late AppColors appColors;
ThemeMode appThemeMode = ThemeMode.system;

// SETTINGS
ThemeManager themeManager = ThemeManager();
Navigate navigate = Navigate();
GlobalKey<ScaffoldState> scaffold = GlobalKey();

// ENUMS
enum MenuState { home, add, others, comments, news, profiles, parts, cars }

enum ScreenState { menu, settings, contact, register, webview }

// CONTROLLERS
final TextEditingController searchBarController = TextEditingController();

// INTEGERS AND DOUBLES
const double borderRadius = 7.0;
const double buttonBorderRadius = 20.0;
const double splashRadius = 18.0;
const int animationDuration = 300;
const int blurAlpha = 153;
const double blurSigmaX = 10.0;
const double blurSigmaY = 10.0;
const double blurOpacity = 0.8;
const double elevation = 1.0;
const double radius = 3.0;
const double margin = 20.0;
const double margin_2 = 15.0;

// COLORS
const colorAccent = Color(0xFF4e82ab);
const colorPrimary = Color(0xFF2d5575);
const blueGrey800 = Color(0xFF37474F);
const blueGrey900 = Color(0xFF263238);
const blueGrey950 = Color(0xFF21272b);
const grey90 = Color(0xFF263228);
const grey900 = Color(0xFF212121);
const grey1000 = Color(0xFF1a1a1a);
const darkSurface = Color(0xFF121212);
const darkBackground = Color(0xFF656565);
const darkAdvBackground = Color(0xFF4e4d4d);
const baseTintColor = Color.fromARGB(255, 253, 250, 253);
