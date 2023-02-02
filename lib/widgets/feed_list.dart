import 'package:feedable/screens/bookmarkScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/feed.dart';
import '../notifiers/feeds_notifier.dart';
import '../screens/feedView.dart';

class FeedList extends ConsumerStatefulWidget {
  bool bookmarkList;
  FeedList(this.bookmarkList);

  @override
  ConsumerState createState() => FeedListState();
}

class FeedListState extends ConsumerState<FeedList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Feed> feeds;
    if (widget.bookmarkList) {
      feeds = ref.watch(feedsNotifierProvider.notifier).bookmarkedFeed();
    } else {
      feeds = ref.watch(feedsNotifierProvider);
    }
    // feeds = widget.feeds;

    debugPrint("Called: FeedList.build");
    return ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, i) => Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    ref
                        .read(feedsNotifierProvider.notifier)
                        .toggleBookmark(feeds[i].url);
                    Feed.save(ref.read(feedsNotifierProvider)[i]);
                  },
                  backgroundColor: feeds[i].bookmarked
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  icon: Icons.bookmark,
                  label: 'Bookmark',
                )
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                  onTap: () {
                    if (!feeds[i].alreadyRead) {
                      ref
                          .read(feedsNotifierProvider.notifier)
                          .toggleAlreadyRead(feeds[i].url);
                      Feed.save(ref.read(feedsNotifierProvider)[i]);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext _context) => SafeArea(
                                child: FeedView(
                                    url: ref
                                        .read(feedsNotifierProvider)[i]
                                        .url))));
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 40.0,
                          child: Text(
                            feeds[i].title,
                            style: TextStyle(
                                fontSize: 14,
                                color: feeds[i].alreadyRead
                                    ? Colors.grey
                                    : Colors.black),
                          )),
                      Container(
                          height: 20.0,
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              feeds[i].bookmarked
                                  ? RichText(
                                      text: TextSpan(children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.bookmark_added_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ]))
                                  : RichText(
                                      text: TextSpan(children: [
                                      WidgetSpan(
                                          child:
                                              Icon(Icons.bookmark_add_outlined))
                                    ])),
                              Text(feeds[i].blogName,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: feeds[i].alreadyRead
                                          ? Colors.grey
                                          : Colors.black)),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                new DateFormat('yyyy/MM/dd(E) HH:mm')
                                    .format(feeds[i].publishedDate!),
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: feeds[i].alreadyRead
                                        ? Colors.grey
                                        : Colors.black),
                              )
                            ],
                          )),
                    ],
                  )),
            )));
  }
}
