import 'dart:convert';

import 'package:feedable/data/data.dart';
import 'package:feedable/util/feeds_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:webfeed_plus/webfeed_plus.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'feed.freezed.dart';

enum FeedType {
  rss,
  atom,
}

@freezed
class Feed with _$Feed {
  const factory Feed(String title, String url, DateTime publishedDate,
      String blogName, bool bookmarked, bool alreadyRead) = _Feed;

  @override
  bool operator ==(Object other) {
    if (other is Feed) {
      return url == other.url;
    }
    return false;
  }

  static Future<Feed> selectByUrl(url) async {
    final Database db = await FeedableDatabase.database;
    final List<Map<String, dynamic>> maps = await db.transaction(
        (txn) => txn.query('feeds', where: 'url = ?', whereArgs: [url]));

    return Feed(
      maps[0]['title'],
      maps[0]['url'],
      DateTime.parse(maps[0]['publishedDate']),
      maps[0]['blogName'],
      maps[0]['bookmarked'] == '1' ? true : false,
      maps[0]['alreadyRead'] == '1' ? true : false,
    );
  }

  static Future<void> save(Feed feed) async {
    final Database db = await FeedableDatabase.database;
    await db.update(
      'feeds',
      toMap(feed),
      where: "url = ?",
      whereArgs: [feed.url],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Map<String, dynamic> toMap(Feed feed) => {
        'title': feed.title,
        'url': feed.url,
        'publishedDate': feed.publishedDate.toString(),
        'blogName': feed.blogName,
        'bookmarked': (feed.bookmarked) ? '1' : '0',
        'alreadyRead': (feed.alreadyRead) ? '1' : '0',
      };

  static Future<void> insertFeeds(List<Feed> feeds) async {
    feeds.forEach((feeds) {
      insertFeed(feeds);
    });
  }

  static Future<void> insertFeed(Feed feed) async {
    final Database db = await FeedableDatabase.database;
    await db.insert(
      'feeds',
      toMap(feed),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Feed>> selectAll() async {
    final Database db = await FeedableDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('feeds');
    return List.generate(maps.length, (i) {
      return Feed(
        maps[i]['title'],
        maps[i]['url'],
        DateTime.parse(maps[i]['publishedDate']),
        maps[i]['blogName'],
        maps[i]['bookmarked'] == '1' ? true : false,
        maps[i]['alreadyRead'] == '1' ? true : false,
      );
    });
  }

  static Future<List<Feed>> getFeeds() async {
    // merge new feeds and stored feeds.
    return await Feed.getNewFeedFromSite() + await Feed.selectAll();
  }

  static Future<List<Feed>> getNewFeedFromSite() async {
    List<Feed> localFeeds = [];
    List<Feed> feedsFromSite = [];
    List<Feed> newFeeds = [];
    localFeeds = await Feed.selectAll();
    feedsFromSite = await Feed.getFeedFromSite();
    newFeeds = feedsFromSite.where((site) {
      var hasSameFeed = false;
      for (final local in localFeeds) {
        if (local.url == site.url) {
          hasSameFeed = true;
          break;
        }
      }
      return !hasSameFeed;
    }).toList();
    feedsFromSite;
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
              item.title ?? '',
              item.link ?? '',
              item.dc!.date!,
              rssFeed.title ?? '',
              false,
              false,
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
                item.title ?? '',
                item.links?.first.href ?? '',
                item.updated ?? DateTime.now(),
                atomFeed.title ?? '',
                false,
                false),
          )
          .toList();
      return blogs;
    }
    return [];
  }
}
