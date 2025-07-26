import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/placeholder_image.dart';
import '../../../providers/locale.dart';
import '../../../providers/navigation.dart';
import '../../../providers/themes.dart';
import '../../../models/article_model.dart';
import '../../../utils/constants.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appColors.dividerColor!, width: 1),
        ),
      ),
      child: ListTile(
        key: Key(widget.article.id.toString()),
        minTileHeight: Constants.articleItemExtent,
        contentPadding: const EdgeInsets.all(8),
        onTap: () {
          context.read<NavigationManager>().setScreen(
            context,
            ScreenState.articleDetail,
            article: widget.article,
          );
        },
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(
          context.watch<LocaleManager>().locale.languageCode == 'ru'
              ? widget.article.titleRu
              : widget.article.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Container(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            context.watch<LocaleManager>().locale.languageCode == 'ru'
                ? widget.article.elapsedTimeRu
                : widget.article.elapsedTime,
            maxLines: 1,
            textWidthBasis: TextWidthBasis.parent,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 12,
              color: appColors.textHintThemeColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        trailing: CachedNetworkImage(
          alignment: Alignment.center,
          imageUrl: widget.article.img,
          fit: BoxFit.fitHeight,
          memCacheHeight: 100,
          memCacheWidth: 200,
          height: double.infinity,
          width: MediaQuery.of(context).size.width * 0.3,
          placeholder: (context, url) => buildImagePlaceholder(context),
          errorWidget: (context, url, error) => buildImagePlaceholder(context),
        ),
      ),
    );
  }
}
