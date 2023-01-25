import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../data/data.dart';

class FeedView extends StatefulWidget {
  final String url;
  const FeedView({super.key, required this.url});

  @override
  State<FeedView> createState() => _FeedViewState(url: url);
}

class ViewWidget {
  final String url;
  ViewWidget({required this.url});

  InAppWebViewController? webViewController;
  final List<ContentBlocker> contentBlockers = [];

  InAppWebView createWidget() {
    // for each Ad URL filter, add a Content Blocker to block its loading.
    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }
    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));

    webViewController?.setSettings(
        settings: InAppWebViewSettings(contentBlockers: contentBlockers));
    return InAppWebView(
      initialSettings: InAppWebViewSettings(contentBlockers: contentBlockers),
      initialUrlRequest: URLRequest(url: WebUri(url)),
      onWebViewCreated: (controller) => webViewController = controller,
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
