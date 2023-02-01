import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/feed.dart';

class FeedsNotifier extends StateNotifier<List<Feed>> {
  FeedsNotifier() : super([]);

  void addFeeds(List<Feed> feeds) {
    // add unique feeds.
    List<Feed> newFeeds = feeds.where((site) {
      var hasSameFeed = false;
      for (final local in state) {
        if (local.url == site.url) {
          hasSameFeed = true;
          break;
        }
      }
      return !hasSameFeed;
    }).toList();
    state = [...newFeeds, ...state];
  }

  void addFeed(Feed feed) {
    state = [...state, feed];
  }

  void removeFeed(String url) {
    state = [
      for (final feed in state)
        if (feed.url != url) feed,
    ];
  }

  Future<bool> HaveNewFeed() {
    return Feed.getNewFeedFromSite().then((value) {
      return value.isNotEmpty;
    });
  }
}

final feedsNotifierProvider =
    StateNotifierProvider<FeedsNotifier, List<Feed>>((ref) {
  return FeedsNotifier();
});

final feedsFutureProvider = FutureProvider<List<Feed>>((ref) async {
  var feedsNotifier = ref.watch(feedsNotifierProvider.notifier);
  return await Feed.getFeeds().then((value) async {
    // add to state
    feedsNotifier.addFeeds(value);

    // add to sqlite3
    Feed.insertFeeds(value);
    return value;
  });
});
