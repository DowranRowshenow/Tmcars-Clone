import 'package:flutter/material.dart';

class CategoryTagChip extends StatelessWidget {
  const CategoryTagChip({
    super.key,
    required this.categoryName,
    required this.color,
  });

  final String categoryName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(categoryName, style: const TextStyle(color: Colors.white)),
    );
  }
}
