import 'package:flutter/material.dart';
import 'package:tmcars/components/no_connection.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/back_icon_button.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _webError = false;

  void _retryLoad() {
    setState(() {
      _isLoading = true; // Show loading indicator again
      _webError = false; // Reset error state
    });
    _controller.loadRequest(Uri.parse(widget.url)); // Attempt to reload
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError webResourceError) {
            if (mounted) setState(() => _webError = true);
          },
          onNavigationRequest: (NavigationRequest navigationRequest) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.title), leading: const BackIconButton()),
      body: Stack(
        children: [
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColorDark),
            ),
          if (_webError)
            NoConnection(onTap: () {
              _retryLoad();
            }),
          if (!_isLoading && !_webError) WebViewWidget(controller: _controller),
        ],
      ),
    );
  }
}
