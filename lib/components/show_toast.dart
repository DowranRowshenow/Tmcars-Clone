import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  /// Displays a customizable Fluttertoast message.
  ///
  /// [message] The text message to display.
  /// [backgroundColor] The background color of the toast. Defaults to Colors.blueGrey.shade900.
  /// [textColor] The text color of the toast message. Defaults to Colors.white.
  /// [toastLength] How long the toast should be visible. Defaults to Toast.LENGTH_SHORT.
  /// [gravity] The position of the toast on the screen. Defaults to ToastGravity.BOTTOM.
  static void showToast({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Toast? toastLength,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      backgroundColor: backgroundColor ?? Colors.blueGrey.shade900,
      textColor: textColor ?? Colors.white,
      msg: message,
      toastLength: toastLength ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }
}
