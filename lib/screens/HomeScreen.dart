import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/feed.dart';
import '../widgets/feed_list.dart';
import '../notifiers/feeds_notifier.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> refreshFeeds() async {
    ref.read(feedsNotifierProvider.notifier);
    ref.refresh(feedsFutureProvider);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Called HomeScreenState.build");
    return Scaffold(
        appBar: AppBar(title: const Text('Feedable')),
        body: ref.watch(feedsFutureProvider).when(
            data: ((feeds) {
              return RefreshIndicator(
                  onRefresh: (() {
                    return refreshFeeds();
                  }),
                  child: FeedList(feeds.take(50).toList()));
            }),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text(error.toString())));
  }
}
