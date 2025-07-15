import 'package:flutter/material.dart';

import 'navigate.dart';
import 'themes.dart';

// GLOBAL VARIABLAES
late Locale locale;
late AppColors appColors;
ThemeMode appThemeMode = ThemeMode.system;
ThemeManager themeManager = ThemeManager();
Navigate navigate = Navigate();
GlobalKey<ScaffoldState> scaffold = GlobalKey();

// ENUMS
enum MenuState { home, add, others, comments, news, profiles, parts, cars }

enum ScreenState { menu, settings, contact, register, webview }

// STRINGS
const String packageVersion = '0.3.0';
const String appName = 'Tmcars Clone';
const String email = "dowranrowshenow@gmail.com";
const String phoneCode = "+993";
const String arrowRight = 'assets/icons/arrow_right.svg';
const String drawerLogoDark = 'assets/images/drawer_logo_dark.webp';
const String drawerLogoLight = 'assets/images/drawer_logo_light.webp';
const String tempImageUrl =
    "https://tapgo.biz:8443/tmcars/images/original/2025/04/04/16/45/21ba5856-2f62-4a80-9495-d02f9c376bd6.png";

// INTEGERS AND DOUBLES
const int animationDuration = 300;
const double blurAlpha = 0.7;
const double borderRadius = 7.0;
const double buttonBorderRadius = 20.0;
const double splashRadius = 18.0;
const double blurSigmaX = 10.0;
const double blurSigmaY = 10.0;
const double blurOpacity = 0.96;
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
