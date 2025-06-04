import 'package:flutter/material.dart';

import '../../../helper/themes.dart';
import '../components/profile_category_card.dart';

class ProfilesCategoryTab extends StatefulWidget {
  const ProfilesCategoryTab({Key? key}) : super(key: key);

  @override
  State<ProfilesCategoryTab> createState() => _ProfilesCategoryTabState();
}

class _ProfilesCategoryTabState extends State<ProfilesCategoryTab> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      color: appColors.menuBackgroundColor,
      padding: const EdgeInsets.all(5),
      // Using GridView.builder for dynamic content
      child: GridView.builder(
        itemCount: 6, // Example: Number of categories
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // Horizontal space between cards
          mainAxisSpacing: 10, // Vertical space between cards
          childAspectRatio: 1, // Aspect ratio of the children (width / height)
        ),
        itemBuilder: (BuildContext context, int index) {
          // You can pass different data to ProfileCategoryCard based on the index
          return const ProfileCategoryCard(
              // Example: Pass a title or ID if your card needs it
              // title: "Category ${index + 1}",
              );
        },
      ),
    );
  }
}
