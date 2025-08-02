import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/back_icon_button.dart';
import '../../components/no_connection.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  double progress = 0;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initWebViewController();
  }

  void _initWebViewController() {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int value) {
            if (mounted) {
              setState(() {
                progress = value / 100;
              });
            }
          },
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _hasError = true;
                _isLoading = false;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: buildBackIconButton(context),
      ),
      body: Stack(
        children: <Widget>[
          _hasError
              ? Center(child: NoConnection(onTap: _initWebViewController))
              : WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(child: CircularProgressIndicator(value: progress)),
        ],
      ),
    );
  }
}
