//  the infrastructure with the local database

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'podcast.dart';

class DataBase {
  List<Podcast> podcasts = [];
  static DataBase? database;

  Future<List<Podcast>> getFavorites() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'podcasts.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> favorites =
        await database.query('favorites');

    podcasts = favorites.map((favorite) {
      return Podcast(
          id: favorite['id'],
          author: favorite['author'],
          title: favorite['title'],
          categories: favorite['categories'],
          imageUrl: favorite['imageUrl'],
          description: favorite['description']);
    }).toList();

    await database.close();
    return podcasts;
  }

  Future<List<Podcast>> removeFavoritePodcast(int podcastId) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'podcasts.db'),
      version: 1,
    );
    await db.delete('favorites', where: 'id = ?', whereArgs: [podcastId]);
    return getFavorites();
  }
}
