import 'dart:ui';

import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/strings.dart';

Future<T?> showSelectLanguageDialog<T>({
  required BuildContext context,
  Color? barrierColor,
  double blurSigmaX = blurSigmaX,
  double blurSigmaY = blurSigmaY,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black.withAlpha(blurAlpha),
    builder: (BuildContext dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
        child: AlertDialog(
          backgroundColor: appColors.themedSurface?.withAlpha(170),
          elevation: elevation,
          title: Text(
            Localization.selectLanguage,
            style: TextStyle(color: appColors.textThemeColor),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory,
              ),
              child: Text(
                Localization.select,
                style: TextStyle(color: colorPrimary),
              ),
              onPressed: () => {},
            ),
          ],
        ),
      );
    },
  );
}
