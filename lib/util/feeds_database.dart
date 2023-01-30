import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FeedableDatabase {
  static Database? cache;
  static Future<Database> get database async {
    // await deleteDatabase(
    //     join(await getDatabasesPath(), 'feedable_database.db')); // Delete

    if (cache != null) {
      return Future.value(cache);
    } else {
      final Future<Database> _database = openDatabase(
        join(await getDatabasesPath(), 'feedable_database.db'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE feeds (title TEXT,url TEXT NOT NULL UNIQUE,publishedDate TEXT,bookmarked TEXT,blogName TEXT,alreadyRead TEXT,PRIMARY KEY(\"url\"));");
        },
        version: 1,
      );
      return _database;
    }
  }
}
