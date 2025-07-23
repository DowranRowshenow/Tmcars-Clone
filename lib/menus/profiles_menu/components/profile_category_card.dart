import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../providers/themes.dart';
import '../../../utils/constants.dart';
import '../../../l10n/app_localizations.dart';

class ProfileCategoryCard extends StatelessWidget {
  const ProfileCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    // Use InkWell for splash effect
    return Card(
      // Card provides elevation and rounded corners by default if not overridden
      // and handles clipping for InkWell splashes.
      margin: EdgeInsets.zero, // GridView handles spacing
      clipBehavior: Clip.antiAlias, // Ensures splash is clipped to card shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // The color is applied to the Card
      color: appColors.themedSurface,
      child: Stack(
        children: [
          Column(
            // Your original content column
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: Constants.tempImageUrl,
                  height: 185,
                  width: 185,
                  // Replace with your actual image URL or asset
                  fit: BoxFit.cover, // Ensure image covers the space
                  placeholder: (context, url) => Center(
                    child: Image.memory(kTransparentImage),
                    //child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 90,
                      height: 90,
                      color: appColors.tileThemeColor,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 50,
                          color: Colors.grey[700]!,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  AppLocalizations.of(context)!.carsAndParts,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: appColors.textThemeColor),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // InkWell is now the direct child of Card
                onTap: () {
                  // Handle tap
                },
                borderRadius: BorderRadius.circular(5),
                // You can also add custom splashColor or highlightColor if needed
                // splashColor: Colors.grey.withValues(alpha:0.3),
                // highlightColor: Colors.blue.withValues(alpha:0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
