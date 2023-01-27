import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/feed.dart';
import '../widgets/feed_item.dart';

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

  Future<void> saveFeeds(feeds) async {
    final prefs = await SharedPreferences.getInstance();
    // update SharedPreferences.
    prefs.setString("feeds", Feed.encode(feeds));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedable')),
      body: ListView.builder(
        itemBuilder: (context, i) => Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    setState(() {
                      if (feeds[i].bookmarked) {
                        feeds[i].bookmarked = false;
                        saveFeeds(feeds);
                      } else {
                        feeds[i].bookmarked = true;
                        saveFeeds(feeds);
                      }
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icons.bookmark,
                  label: 'Bookmark',
                )
              ],
            ),
            child: FeedItem(feeds[i].title, feeds[i].blogName, feeds[i].url,
                feeds[i].publishedDate!, feeds[i].bookmarked)),
        itemCount: feeds.length,
      ),
    );
  }
}
