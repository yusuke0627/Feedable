import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/feed.dart';
import '../screens/feedView.dart';

class FeedList extends StatefulWidget {
  List<Feed> feeds;
  FeedList(this.feeds, {super.key});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Called: FeedList.build");
    return ListView.builder(
        itemCount: widget.feeds.length,
        itemBuilder: (context, i) => Slidable(
            key: UniqueKey(),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {
                    setState(() {
                      if (widget.feeds[i].bookmarked) {
                        widget.feeds[i] =
                            widget.feeds[i].copyWith(bookmarked: false);
                        Feed.save(widget.feeds[i]);
                      } else {
                        widget.feeds[i] =
                            widget.feeds[i].copyWith(bookmarked: true);
                        Feed.save(widget.feeds[i]);
                      }
                    });
                  },
                  backgroundColor: widget.feeds[i].bookmarked
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                  icon: Icons.bookmark,
                  label: 'Bookmark',
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                  onTap: () {
                    setState(() {
                      widget.feeds[i] =
                          widget.feeds[i].copyWith(alreadyRead: true);
                      Feed.save(widget.feeds[i]);
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SafeArea(
                                child: FeedView(url: widget.feeds[i].url))));
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 40.0,
                          child: Text(
                            widget.feeds[i].title,
                            style: TextStyle(
                                fontSize: 14,
                                color: widget.feeds[i].alreadyRead
                                    ? Colors.grey
                                    : Colors.black),
                          )),
                      Container(
                          height: 20.0,
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              widget.feeds[i].bookmarked
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
                                      text: const TextSpan(children: [
                                      WidgetSpan(
                                          child:
                                              Icon(Icons.bookmark_add_outlined))
                                    ])),
                              Text(widget.feeds[i].blogName,
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: widget.feeds[i].alreadyRead
                                          ? Colors.grey
                                          : Colors.black)),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                DateFormat('yyyy/MM/dd(E) HH:mm')
                                    .format(widget.feeds[i].publishedDate),
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: widget.feeds[i].alreadyRead
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
