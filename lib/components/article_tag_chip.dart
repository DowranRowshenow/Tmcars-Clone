import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article_detail_model.dart';
import '../providers/locale.dart';
import '../providers/themes.dart';

class ArticleTagChip extends StatelessWidget {
  const ArticleTagChip({super.key, required this.articleTag, this.onTap});
  final ArticleTag articleTag;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final Locale locale = context.read<LocaleManager>().locale;

    return ElevatedButton(
      onPressed: onTap == null ? null : onTap as void Function(),
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(appColors.focusColor),
        backgroundColor: WidgetStateProperty.all(appColors.tagColor),
      ),
      child: Text(
        articleTag.getName(locale.languageCode),
        style: TextStyle(color: appColors.textThemeColor),
      ),
    );
  }
}
