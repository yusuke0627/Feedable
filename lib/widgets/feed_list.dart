import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/feed.dart';
import '../screens/feedView.dart';

class FeedList extends StatefulWidget {
  List<Feed> feeds;
  FeedList(this.feeds);

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  @override
  Widget build(BuildContext context) {
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
                        widget.feeds[i].bookmarked = false;
                        Feed.saveFeeds(widget.feeds);
                      } else {
                        widget.feeds[i].bookmarked = true;
                        Feed.saveFeeds(widget.feeds);
                      }
                    });
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icons.bookmark,
                  label: 'Bookmark',
                )
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext _context) =>
                                    FeedView(url: widget.feeds[i].url)))
                      },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 40.0,
                          child: Text(
                            widget.feeds[i].title,
                            style: TextStyle(fontSize: 14),
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
                                      text: TextSpan(children: [
                                      WidgetSpan(
                                          child:
                                              Icon(Icons.bookmark_add_outlined))
                                    ])),
                              Text(widget.feeds[i].blogName,
                                  style: TextStyle(fontSize: 10.0)),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                new DateFormat('yyyy/MM/dd(E) HH:mm')
                                    .format(widget.feeds[i].publishedDate!),
                                style: TextStyle(fontSize: 10.0),
                              )
                            ],
                          )),
                    ],
                  )),
            )));
  }
}
