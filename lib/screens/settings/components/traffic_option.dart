import 'package:flutter/material.dart';

import '../../../helper/constants.dart' as constants;

class TrafficOption extends StatelessWidget {
  final String text;
  final int selectedValue;
  final int value;
  final VoidCallback onTap;

  const TrafficOption({
    super.key,
    required this.text,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      title: Text(
        text,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: constants.appColors.textThemeColor,
          fontWeight: selectedValue == value
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      leading: Radio<int>(
        value: value,
        groupValue: selectedValue,
        onChanged: (int? value) {
          if (value != null) {
            onTap();
          }
        },
      ),
      onTap: onTap,
    );
  }
}
