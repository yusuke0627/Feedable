import 'package:flutter/material.dart';

import '../screens/feedView.dart';

class FeedItem extends StatelessWidget {
  String title;
  String siteName;
  String url;
  FeedItem(this.title, this.siteName, this.url);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext _context) => FeedView(url: url)))
              },
          title: Row(
            children: [
              Container(
                  height: 40.0,
                  width: 250.0,
                  color: Colors.amberAccent,
                  child: Text(title)),
              Container(
                  height: 40.0,
                  width: 100.0,
                  color: Colors.amber,
                  alignment: Alignment.bottomRight,
                  child: Text(siteName, style: TextStyle(fontSize: 10.0)))
            ],
          )),
    );
  }
}
