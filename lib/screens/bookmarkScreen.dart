import 'package:flutter/material.dart';

import '../models/feed.dart';
import '../widgets/feed_list.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Feed> feeds = [];

  _BookmarkScreenState() {
    loadFeeds();
  }

  void loadFeeds() async {
    await Feed.selectAll().then((value) => setState(() {
          feeds = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Feedable')),
        body: FeedList(feeds.where((element) => element.bookmarked).toList()));
  }
}
