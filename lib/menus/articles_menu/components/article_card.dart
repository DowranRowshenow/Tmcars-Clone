import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/locale.dart';
import '../../../utils/themes.dart';
import '../../../models/article_model.dart';

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
        minTileHeight: 90,
        contentPadding: EdgeInsets.all(8),
        onTap: () {},
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(
          context.watch<LocaleManager>().locale == Locale('ru')
              ? widget.article.titleRu
              : widget.article.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Container(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            context.watch<LocaleManager>().locale == Locale('ru')
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
          height: double.infinity,
          width: MediaQuery.of(context).size.width * 0.3,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Container(
              width: 90,
              height: 90,
              color: appColors.tileThemeColor,
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              width: 90,
              height: 90,
              color: appColors.tileThemeColor,
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
