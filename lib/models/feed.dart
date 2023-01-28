import 'dart:convert';

import 'package:feedable/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed_plus/webfeed_plus.dart';

enum FeedType {
  rss,
  atom,
}

class Feed {
  final String title;
  final String url;
  final DateTime? publishedDate;
  final String blogName;
  bool bookmarked = false;
  Feed(
      {required this.title,
      required this.url,
      required this.publishedDate,
      required this.blogName,
      this.bookmarked = false});

  @override
  bool operator ==(Object other) {
    if (other is Feed) {
      return url == other.url;
    }
    return false;
  }

  factory Feed.fromJson(Map<String, dynamic> jsonData) {
    return Feed(
      title: jsonData['title'],
      url: jsonData['url'],
      publishedDate: DateTime.parse(jsonData['publishedDate']),
      blogName: jsonData['blogName'],
      bookmarked: jsonData['bookmarked'],
    );
  }

  static Map<String, dynamic> toMap(Feed feed) => {
        'title': feed.title,
        'url': feed.url,
        'publishedDate': feed.publishedDate.toString(),
        'blogName': feed.blogName,
        'bookmarked': feed.bookmarked,
      };

  static String encode(List<Feed> feeds) => json.encode(
        feeds.map<Map<String, dynamic>>((feed) => Feed.toMap(feed)).toList(),
      );

  static List<Feed> decode(String feeds) =>
      (json.decode(feeds) as List<dynamic>)
          .map<Feed>((item) => Feed.fromJson(item))
          .toList();

  static Future<void> saveFeeds(List<Feed> feeds) async {
    final prefs = await SharedPreferences.getInstance();
    // update SharedPreferences.
    prefs.setString("feeds", Feed.encode(feeds));
  }

  static Future<List<Feed>> loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("feeds")) {
      String feedsString = prefs.getString("feeds")!;
      if (feedsString.isNotEmpty) {
        return Feed.decode(feedsString);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<List<Feed>> getFeeds() async {
    List<Feed> currentFeeds = await Feed.loadFromSharedPreferences();
    // merge new feeds to localstorage feeds.
    return await Feed.getNewFeedFromSite() + currentFeeds;
  }

  static Future<List<Feed>> getNewFeedFromSite() async {
    List<Feed> localFeeds = [];
    List<Feed> feedsFromSite = [];
    List<Feed> newFeeds = [];
    localFeeds = await Feed.loadFromSharedPreferences();
    feedsFromSite = await Feed.getFeedFromSite();
    newFeeds = feedsFromSite.where((a) => !localFeeds.contains(a)).toList();

    return newFeeds;
  }

  static Future<List<Feed>> getFeedFromSite() async {
    List<List<Feed>> feedsEachSite = [];
    await Future.forEach(Sites, (site) async {
      FeedType? feedType;
      if (site["feedType"]! == "rss") {
        feedType = FeedType.rss;
      } else if (site["feedType"]! == "atom") {
        feedType = FeedType.atom;
        // Cannot reach this statement.
      } else {
        feedType = null;
      }
      await _getFeedFromSite(site["url"]!, feedType!).then((value) {
        feedsEachSite.add(value);
      });
    });

    List<Feed> feeds = feedsEachSite.expand((element) => element).toList();
    feeds.sort((a, b) => b.publishedDate!.compareTo(a.publishedDate!));

    return feeds;
  }

  static Future<List<Feed>> _getFeedFromSite(String url, FeedType type) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to getFeed');
    }
    if (type == FeedType.rss) {
      final rssFeed = RssFeed.parse(response.body);
      final rssItemlist = rssFeed.items ?? <RssItem>[];
      final blogs = rssItemlist
          .map(
            (item) => Feed(
              url: item.link ?? '',
              title: item.title ?? '',
              publishedDate: item.dc!.date!,
              blogName: rssFeed.title ?? '',
            ),
          )
          .toList();
      return blogs;
    } else if (type == FeedType.atom) {
      final atomFeed = AtomFeed.parse(response.body);
      final atomItemlist = atomFeed.items ?? <AtomItem>[];
      final blogs = atomItemlist
          .map(
            (item) => Feed(
              url: item.links?.first.href ?? '',
              title: item.title ?? '',
              publishedDate: item.updated ?? DateTime.now(),
              blogName: atomFeed.title ?? '',
            ),
          )
          .toList();
      return blogs;
    }
    return [];
  }
}
