import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../components/placeholder_image.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/themes.dart';
import '../../../providers/traffic.dart';
import '../../../utils/constants.dart';

class ProfileCategoryCard extends StatelessWidget {
  const ProfileCategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Card(
      margin: EdgeInsets.zero, // GridView handles spacing
      clipBehavior: Clip.antiAlias, // Ensures splash is clipped to card shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: appColors.themedSurface,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              Expanded(
                child: context.watch<TrafficManager>().isStandart()
                    ? CachedNetworkImage(
                        imageUrl: Constants.tempImageUrl,
                        height: 185,
                        width: 185,
                        fit: BoxFit.cover, // Ensure image covers the space
                        placeholder: (context, url) => Center(
                          child: Image.memory(kTransparentImage),
                          //child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            buildImagePlaceholder(context),
                      )
                    : buildImagePlaceholder(context),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  AppLocalizations.of(context)!.carsAndParts,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: appColors.textThemeColor),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
