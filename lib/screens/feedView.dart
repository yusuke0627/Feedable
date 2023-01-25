import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return ViewWidget(url: url).createWidget();
  }
}
