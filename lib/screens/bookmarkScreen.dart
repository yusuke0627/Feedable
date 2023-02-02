import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/feed.dart';
import '../widgets/feed_list.dart';
import '../notifiers/feeds_notifier.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({super.key});

  @override
  ConsumerState createState() => BookmarkScreenState();
}

class BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Called BookmarkScreenState.build");
    return Scaffold(
        appBar: AppBar(title: Text('Feedable')),
        body: ref.watch(feedsFutureProvider).when(
            data: ((feeds) {
              return FeedList(true);
            }),
            loading: () => Center(child: const CircularProgressIndicator()),
            error: (error, _) => Text(error.toString())));
  }
}
