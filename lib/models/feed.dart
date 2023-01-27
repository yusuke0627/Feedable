class Feed {
  final String title;
  final String url;
  final DateTime? publishedDate;
  final String blogName;
  bool bookmarked = false;
  Feed(
      {required this.title,
      required this.url,
      required this.publishedDate,
      required this.blogName,
      this.bookmarked = false});
}
