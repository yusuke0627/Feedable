import 'package:flutter/material.dart';
import '../models/feed.dart';
import '../widgets/feed_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Feed> feeds = [];

  _HomeScreenState() {
    loadFeeds();
  }

  void loadFeeds() async {
    await Feed.getFeeds().then((value) => setState(() {
          feeds = value;
        }));

    // save feeds to SharedPreferences.
    Feed.saveFeeds(feeds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Feedable')), body: FeedList(feeds));
  }
}
