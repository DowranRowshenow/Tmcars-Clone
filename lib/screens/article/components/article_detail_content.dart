import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../screens/article/components/nearest_article_card.dart';
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
        Container(
          color: Colors.grey.withAlpha(70),
          height: 180,
          child: Container(),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          // Doesnot have itemExtent it is dynamic
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: nearestArticles.length,
          itemBuilder: (context, index) {
            return NearestArticleCard(
              key: ValueKey(nearestArticles[index].id),
              nearestArticle: nearestArticles[index],
            );
          },
        ),
      ],
    );
  }
}
