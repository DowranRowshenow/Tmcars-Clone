import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/scroll/glowless_scroll_behavior.dart';
import '../../l10n/app_localizations.dart';
import '../../models/article_detail_model.dart';
import '../../models/article_model.dart';
import '../../providers/themes.dart';
import '../../utils/constants.dart';
import '../../utils/server.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
    required this.languageCode,
  });
  final Article article;
  final String languageCode;

  @override
  // ignore: library_private_types_in_public_api
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  ArticleDetail? articleDetail;
  static const double _expandedHeight = 250.0;
  late Future<String> _htmlContentFuture;

  @override
  void initState() {
    super.initState();
    _loadArticle();
    _htmlContentFuture = Server.fetchHtmlContent(
      widget.languageCode == "ru"
          ? widget.article.openUrlRu
          : widget.article.openUrl,
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadArticle() async {
    articleDetail = await Server.getArticle(widget.article.id);
    setState(() {});
  }

  void _onScroll() {
    final bool shouldShowTitle =
        _scrollController.hasClients &&
        _scrollController.offset >= _expandedHeight - kToolbarHeight;
    if (shouldShowTitle != _showTitle) {
      setState(() {
        _showTitle = shouldShowTitle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final String title = widget.languageCode == "ru"
        ? widget.article.titleRu
        : widget.article.title;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        scrollBehavior: GlowlessScrollBehavior(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _expandedHeight,
            pinned: true,
            floating: false,
            snap: false,
            title: AnimatedOpacity(
              opacity: _showTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Text(title),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              splashRadius: Constants.splashRadius,
            ),
            actions: <Widget>[
              PopupMenuButton<int>(
                menuPadding: EdgeInsets.all(0),
                color: appColors.themedSurface,
                splashRadius: Constants.splashRadius,
                onSelected: (int value) {
                  switch (value) {
                    case 0:
                      SharePlus.instance.share(
                        ShareParams(
                          text: widget.languageCode == 'ru'
                              ? articleDetail?.shareUrlRu ?? ""
                              : articleDetail?.shareUrl ?? "",
                        ),
                      );
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(AppLocalizations.of(context)!.shareLink),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.article.img,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: appColors.tileThemeColor),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          // This is the body of the screen.
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.languageCode == 'ru'
                          ? widget.article.titleRu
                          : widget.article.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.languageCode == 'ru'
                              ? widget.article.elapsedTimeRu
                              : widget.article.elapsedTime,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.visibility, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          articleDetail?.viewCount.toString() ?? "",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 80,
                      width: double.infinity,
                      color: Colors.grey[200],
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<String>(
                      future: _htmlContentFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return Html(
                            data: snapshot.data,
                            onLinkTap: (url, attributes, element) async {
                              if (url != null) {
                                await launchUrl(Uri.parse(url));
                              }
                            },
                            style: {
                              "*": Style(backgroundColor: Colors.transparent),
                              "body": Style(
                                backgroundColor: Colors.transparent,
                                color: appColors.textThemeColor,
                                fontSize: FontSize(16),
                                fontFamily: 'Roboto', // Use system font
                              ),
                              "p": Style(
                                backgroundColor: Colors.transparent,
                                color: appColors.textThemeColor,
                                fontSize: FontSize(16),
                                lineHeight: LineHeight(1.5),
                              ),
                              "span": Style(color: appColors.textThemeColor),
                              "div": Style(
                                backgroundColor: Colors.transparent,
                                color: appColors.textThemeColor,
                              ),
                              "a": Style(color: appColors.text2ThemeColor),
                            },
                          );
                        } else {
                          return Center(child: Text('No content available.'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
