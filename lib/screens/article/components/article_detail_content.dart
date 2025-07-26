import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../models/article_detail_model.dart';
import '../../../models/article_model.dart';
import '../../../providers/themes.dart';
import 'html_renderer.dart';
import 'tag_category_chip.dart';

class ArticleDetailContent extends StatelessWidget {
  final ArticleDetail? articleDetail;
  final Article article;
  final String languageCode;
  final Future<String> htmlContentFuture;
  final AppColors appColors;
  final Color tagColor;
  final List<Article> nearestArticles;

  const ArticleDetailContent({
    super.key,
    required this.articleDetail,
    required this.article,
    required this.languageCode,
    required this.htmlContentFuture,
    required this.appColors,
    required this.tagColor,
    required this.nearestArticles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (articleDetail != null)
          TagCategoryChip(
            categoryName: languageCode == 'ru'
                ? articleDetail!.categoryNameRu
                : articleDetail!.categoryName,
            color: context.watch<ThemeManager>().isDark()
                ? Colors.blueGrey.shade900
                : tagColor,
          ),
        Text(
          languageCode == 'ru' ? article.titleRu : article.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              languageCode == 'ru'
                  ? article.elapsedTimeRu
                  : article.elapsedTime,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.visibility, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              articleDetail?.viewCount.toString() ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Placeholder for an ad or other content
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.grey.withAlpha(70),
        ),
        const SizedBox(height: 10),
        HtmlRenderer(future: htmlContentFuture),
        const SizedBox(height: 10),
        if (articleDetail != null)
          if (articleDetail!.tags.isNotEmpty)
            Text(AppLocalizations.of(context)!.tags.toUpperCase()),
        const SizedBox(height: 10),
        if (articleDetail != null)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: articleDetail!.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: appColors.tagColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  languageCode == 'ru' ? "#${tag.nameRu}" : "#${tag.name}",
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 10),
        Container(color: Colors.grey.shade200, height: 180, child: Container()),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: nearestArticles.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: nearestArticles[index].img,
                        placeholder: (context, url) => Container(
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
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
                            ? nearestArticles[index].titleRu
                            : nearestArticles[index].title,
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
                            ? nearestArticles[index].elapsedTimeRu
                            : nearestArticles[index].elapsedTime,
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
                            // Handle tap
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
          },
        ),
      ],
    );
  }
}
