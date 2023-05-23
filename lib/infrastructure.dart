//  the infrastructure will be the local database

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'podcast.dart';

class DataBase {
  List<Podcast> podcasts = [];

  Future<List<Podcast>> accessFavoritesTable() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'shade_casts.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> favorites =
        await database.query('favorites');

    podcasts = favorites.map((favorite) {
      return Podcast(
        id: favorite['id'],
        creator: favorite['creator'],
        title: favorite['title'],
        status: favorite['status'],
      );
    }).toList();

    await database.close();
    return podcasts;
  }
}
