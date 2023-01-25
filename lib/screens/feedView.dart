import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FeedView extends StatefulWidget {
  final String url;
  const FeedView({super.key, required this.url});

  @override
  State<FeedView> createState() => _FeedViewState(url: url);
}

class ViewWidget {
  final String url;
  ViewWidget({required this.url});

  InAppWebView createWidget() {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
    );
  }
}

class _FeedViewState extends State<FeedView> {
  final String url;
  _FeedViewState({required this.url});

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

  @override
  Widget build(BuildContext context) {
    return ViewWidget(url: url).createWidget();
  }
}
