import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../helper/size_config.dart';
import '../../../helper/themes.dart';

class ProfileCategoryCard extends StatefulWidget {
  const ProfileCategoryCard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileCategoryCardState createState() => _ProfileCategoryCardState();
}

class _ProfileCategoryCardState extends State<ProfileCategoryCard> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    // Use InkWell for splash effect
    return Card(
      // Card provides elevation and rounded corners by default if not overridden
      // and handles clipping for InkWell splashes.
      margin: EdgeInsets.zero, // GridView handles spacing
      clipBehavior: Clip.antiAlias, // Ensures splash is clipped to card shape
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
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
                  imageUrl:
                      'https://tapgo.biz:8443/tmcars/images/original/2025/04/04/16/45/21ba5856-2f62-4a80-9495-d02f9c376bd6.png',
                  height: getProportionateScreenHeight(185),
                  width: getProportionateScreenHeight(185),
                  // Replace with your actual image URL or asset
                  fit: BoxFit.cover, // Ensure image covers the space
                  placeholder: (context, url) => Center(
                    child: Image.memory(kTransparentImage),
                    //child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) {
                    if (kDebugMode) {
                      print('Error loading image: $url, error: $error');
                    }
                    return Container(
                      width: getProportionateScreenWidth(90),
                      height: getProportionateScreenHeight(90),
                      color: appColors.tileThemeColor,
                      child: Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: getProportionateScreenHeight(100),
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Awtoulag we şaýlar',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: appColors.textThemeColor,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
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
                // splashColor: Colors.grey.withOpacity(0.3),
                // highlightColor: Colors.blue.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
