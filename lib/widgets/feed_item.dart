import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/feedView.dart';

class FeedItem extends StatelessWidget {
  String title;
  String siteName;
  String url;
  DateTime publishedDate;
  bool bookmarked;

  FeedItem(
      this.title, this.siteName, this.url, this.publishedDate, this.bookmarked);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext _context) => FeedView(url: url)))
              },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 40.0,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 14),
                  )),
              Container(
                  height: 20.0,
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      bookmarked
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
                                  child: Icon(Icons.bookmark_add_outlined))
                            ])),
                      Text(siteName, style: TextStyle(fontSize: 10.0)),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        new DateFormat('yyyy/MM/dd(E) HH:mm')
                            .format(publishedDate),
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
