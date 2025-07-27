import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../models/article_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/navigation.dart';
import '../../../providers/traffic.dart';

class NearestArticleCard extends StatelessWidget {
  const NearestArticleCard({super.key, required this.nearestArticle});
  final Article nearestArticle;

  @override
  Widget build(BuildContext context) {
    final String languageCode = context
        .watch<LocaleManager>()
        .locale
        .languageCode;

    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: context.watch<TrafficManager>().getTrafficMode == 0
                  ? CachedNetworkImage(
                      imageUrl: nearestArticle.img,
                      placeholder: (context, url) => Container(
                        height: 100,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    )
                  : buildImagePlaceholder(context),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // Top is transparent
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 10,
              right: 10,
              child: Text(
                languageCode == 'ru'
                    ? nearestArticle.titleRu
                    : nearestArticle.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                languageCode == 'ru'
                    ? nearestArticle.elapsedTimeRu
                    : nearestArticle.elapsedTime,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<NavigationManager>().setScreen(
                      context,
                      ScreenState.articleDetail,
                      article: nearestArticle,
                    );
                  },
                  splashColor: Colors.grey.withAlpha(100),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
