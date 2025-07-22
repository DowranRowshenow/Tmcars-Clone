import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/no_connection.dart';
import '../../utils/constants.dart' as constants;

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

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
      ..setBackgroundColor(Colors.transparent)
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
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          splashRadius: constants.splashRadius,
          splashColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          if (_isLoading) Center(child: CircularProgressIndicator()),
          if (_webError) NoConnection(onTap: () => _retryLoad()),
          if (!_isLoading && !_webError) WebViewWidget(controller: _controller),
        ],
      ),
    );
  }
}
