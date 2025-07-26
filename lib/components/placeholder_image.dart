import 'package:flutter/material.dart';

import '../providers/themes.dart';
import '../utils/constants.dart';

Widget buildImagePlaceholder(BuildContext context) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;
  return Container(
    width: Constants.placeHolderSize,
    height: Constants.placeHolderSize,
    color: appColors.tileThemeColor,
    child: Center(
      child: Icon(
        Icons.broken_image_outlined,
        size: 50,
        color: Colors.grey[700]!,
      ),
    ),
  );
}
