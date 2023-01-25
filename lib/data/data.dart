import 'package:feedable/models/feed.dart';

// Feed
final _feed001 = Feed(
    title: "_feed001",
    blogName: "サイト名 A",
    url: "",
    publishedDate: DateTime.now());
final _feed002 = Feed(
    title: "_feed002",
    blogName: "サイト名 B",
    url: "",
    publishedDate: DateTime.now());

final List<Feed> feeds = [_feed001, _feed002];
