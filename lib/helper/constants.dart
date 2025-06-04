import 'package:flutter/material.dart';

import 'navigate.dart';
import 'themes.dart';

// APPLICATION
const String packageVersion = '1.1.0';

// SETTINGS
ThemeManager themeManager = ThemeManager();
Navigate navigate = Navigate();
GlobalKey<ScaffoldState> scaffold = GlobalKey();

// ENUMS
enum MenuState { home, add, others, comments, news, profiles, parts, cars }

enum ScreenState { menu, settings, contact, register, webview }

// CONTROLLERS
final phoneNumberController = TextEditingController();
final emailAddressController = TextEditingController();
final searchBarController = TextEditingController();

// INTEGERS AND DOUBLES
const double borderRadius = 7;
const double buttonBorderRadius = 20;
const double splashRadius = 18;

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
