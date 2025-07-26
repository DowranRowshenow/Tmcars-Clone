import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/themes.dart';

class HtmlRenderer extends StatelessWidget {
  const HtmlRenderer({super.key, required this.future});
  final Future<String> future;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return FutureBuilder<String>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: const EdgeInsets.all(60),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          return Html(
            data: snapshot.data,
            onLinkTap: (url, attributes, element) async {
              if (url != null) {
                try {
                  await launchUrl(Uri.parse(url));
                } catch (e) {
                  // TODO: implement intent tel:
                }
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
                lineHeight: const LineHeight(1.5),
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
          return const Center(child: Text('No content available.'));
        }
      },
    );
  }
}
