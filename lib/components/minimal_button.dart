import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MinimalButton extends StatelessWidget {
  const MinimalButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: Theme.of(context).extension<AppColors>()!.buttonColor,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Theme.of(context).extension<AppColors>()!.borderColor!,
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).extension<AppColors>()!.text2ThemeColor,
          ),
        ),
      ),
    );
  }
}
