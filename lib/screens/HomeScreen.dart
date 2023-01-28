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

  Future<void> loadFeeds() async {
    feeds = await Feed.getFeeds();
    // save feeds to SharedPreferences.
    Feed.saveFeeds(feeds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Feedable')),
        body: FutureBuilder(
            future: loadFeeds(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.error != null) {
                // TODO erro control
                // return Center(child: Text('something error occur'));
              }
              ;

              return FeedList(feeds);
            }));
  }
}
