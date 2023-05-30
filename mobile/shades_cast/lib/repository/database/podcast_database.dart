import 'dart:ffi';

import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/episode.dart';

class PodcastDatabase {
  final int version = 1;
  Database? db;

  static final PodcastDatabase _dbHelper = PodcastDatabase._internal();
  PodcastDatabase._internal() {
    initializeDatabase();
  }
  factory PodcastDatabase() {
    return _dbHelper;
  }
  Future<void> initializeDatabase() async {
    db = await openDb();
  }

  Future testDb() async {
    db = await openDb();
    await db!.execute('INSERT INTO lists VALUES (0, "Fruit", 2)');
    await db!.execute(
        'INSERT INTO items VALUES (0, 0, "Apples", "2 Kg", "Better if they are green")');
    List lists = await db!.rawQuery('select * from lists');
    List items = await db!.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'podcast.db'),
          onCreate: (database, version) {
        database.execute('''
          CREATE TABLE podcasts(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            author TEXT,
            imageUrl TEXT,
            categories TEXT
          )
          ''');
        database.execute('''
          CREATE TABLE episodes(
            id TEXT PRIMARY KEY,
            podcastId TEXT,
            title TEXT,
            description TEXT,
            audioUrl TEXT
          )
          ''');
        database.execute('''
          CREATE TABLE favorites(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            author TEXT,
            imageUrl TEXT,
            categories TEXT
          )
        ''');
      }, version: version);
    }
    return db!;
  }

  ////////////////////////////////
  ///
  ///
  ///

  Future<void> savePodcast(dynamic podcast) async {
    // print((podcast.toMap()['id'].runtimeType));
    // print('eheheeeheheheheh');
    final db = await openDb();
    await db.insert('podcasts', podcast.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> savePodcasts(List<dynamic> podcasts) async {
    final db = await openDb();
    for (Podcast podcast in podcasts) {
      await db.insert('podcasts', podcast.toMap());
    }
  }

  Future<void> deletePodcast(String podcastId) async {
    final db = await openDb();
    await db.delete('podcasts', where: 'id = ?', whereArgs: [podcastId]);
  }

////////////////////////////////////////////////
  ///
  ///
  ///
  Future<Podcast?> getPodcastById(String podcastId) async {
    final db = await openDb();
    List<Map<String, dynamic>> maps =
        await db.query('podcasts', where: 'id = ?', whereArgs: [podcastId]);

    if (maps.isNotEmpty) {
      return Podcast.fromMap(maps.first);
    } else {
      return null;
    }
  }

//////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<List<Podcast>> getPodcasts() async {
    // print('heerrrrrrrrrrrro');
    final db = await openDb();

    print('got here');

    final List<Map<String, dynamic>> queryRows = await db.query('podcasts');
    print('got here too');

    return List.generate(queryRows.length, (index) {
      return Podcast.fromMap(queryRows[index]);
    });
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  Future<List<Podcast>?> getFavorites() async {
    final db = await openDb();
    final List<Map<String, dynamic>> queryRows = await db.query('favorites');
    return List.generate(queryRows.length, (index) {
      return Podcast.fromMap(queryRows[index]);
    });
  }

  ////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> deleteFromFavorite(String podcastId) async {
    final db = await openDb();
    await db.delete('favorites', where: 'id = ?', whereArgs: [podcastId]);
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> saveFavorites(List<Podcast> favorites) async {
    final db = await openDb();
    Batch batch = db.batch();

    for (Podcast podcast in favorites) {
      batch.insert(
        'favorites',
        {
          'id': podcast.id.toString(),
          'title': podcast.title,
          'description':
              podcast.description ?? '', // Ensure description is not null
          'author': podcast.author ?? '',
          'imageUrl': podcast.imageUrl.toString(),
          'categories': podcast.categories?.toList()[0][0],
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> saveEpisodes(List<Episode> episodes) async {
    final db = await openDb();
    Batch batch = db.batch();

    for (Episode episode in episodes) {
      batch.insert(
        'episodes',
        episode.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///

  Future<List<Episode>> getEpisodes(String podcastId) async {
    final db = await openDb();
    final List<Map<String, dynamic>> queryRows = await db
        .query('episodes', where: 'podcastId = ?', whereArgs: [podcastId]);
    return queryRows.map((row) => Episode.fromMap(row)).toList();
  }

  ////////////////////////////////////////////////////////////////
  ////
  ///
  ///

  Future<void> saveEpisode(Episode episode) async {
    final db = await openDb();
    await db.insert('episodes', episode.toMap());
  }

////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> deleteEpisode(String episodeId) async {
    final db = await openDb();
    db.delete('episodes', where: 'id =?', whereArgs: [episodeId]);
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<Funfact?> getFunfact() async {
    final db = await openDb();
    List<Map<String, dynamic>> result = await db.query(
      'funfacts',
      limit: 1, // Limit the query to retrieve only one row
    );
    if (result.isNotEmpty) {
      return Funfact.fromMap(result.first);
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  Future<void> saveFunfact(Funfact funfact) async {
    final db = await openDb();
    await db.insert('funfacts', funfact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
