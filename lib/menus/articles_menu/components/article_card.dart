import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/article_model.dart';
import '../../../providers/locale.dart';
import '../../../providers/navigation.dart';
import '../../../providers/themes.dart';
import 'article_card_image.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Locale locale = context.watch<LocaleManager>().locale;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appColors.dividerColor!, width: 1),
        ),
      ),
      child: ListTile(
        minVerticalPadding: 0,
        // minTileHeight: Constants.articleItemExtent,
        contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        onTap: () {
          context.read<NavigationManager>().setScreen(
            context,
            ScreenState.articleDetail,
            article: article,
          );
        },
        titleAlignment: ListTileTitleAlignment.center,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locale.languageCode == 'ru'
                        ? article.titleRu
                        : article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    locale.languageCode == 'ru'
                        ? article.elapsedTimeRu
                        : article.elapsedTime,
                    maxLines: 1,
                    textWidthBasis: TextWidthBasis.parent,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      color: appColors.textHintThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ArticleCardImage(
              articleImg: article.img,
              videoExist: article.videoExist,
            ),
          ],
        ),
      ),
    );
  }
}
