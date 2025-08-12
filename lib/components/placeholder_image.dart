import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

Widget buildImagePlaceholder(
  BuildContext context, {
  double? height,
  double? width,
  double? iconSize,
  IconData? icon,
}) {
  final AppColors appColors = Theme.of(context).extension<AppColors>()!;
  return Container(
    width: width ?? Constants.placeHolderSize,
    height: height ?? Constants.placeHolderSize,
    color: appColors.tileThemeColor,
    child: Center(
      child: Icon(
        icon ?? Icons.broken_image_outlined,
        size: iconSize ?? 50,
        color: Colors.grey[700]!,
      ),
    ),
  );
}
