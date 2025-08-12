import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/article_tag_chip.dart';
import '../../../components/category_tag_chip.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/article_detail_model.dart';
import '../../../models/article_model.dart';
import '../../../providers/navigation.dart';
import '../../../screens/article/components/nearest_article_card.dart';
import '../../../utils/app_colors.dart';
import 'html_renderer.dart';

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
    final AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        articleDetail != null
            ? CategoryTagChip(
                categoryName: articleDetail!.getCategoryName(languageCode),
                color: tagColor,
              )
            : const SizedBox(height: 44),
        Text(
          article.getTitle(languageCode),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              article.getElapsedTime(languageCode),
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
            Text(appLocalizations.tags.toUpperCase()),
        const SizedBox(height: 10),
        if (articleDetail != null)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: articleDetail!.tags.map((ArticleTag tag) {
              return ArticleTagChip(
                articleTag: tag,
                onTap: () {
                  context.read<NavigationManager>().setScreen(
                    context,
                    ScreenState.searchArticles,
                    articleTags: <ArticleTag>[tag],
                  );
                },
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
          itemBuilder: (BuildContext context, int index) {
            return NearestArticleCard(
              key: ValueKey<int>(nearestArticles[index].id),
              nearestArticle: nearestArticles[index],
            );
          },
        ),
      ],
    );
  }
}
