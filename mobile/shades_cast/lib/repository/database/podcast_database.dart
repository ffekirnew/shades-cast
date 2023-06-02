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
        database.execute('''
              CREATE TABLE funfacts(
                id TEXT PRIMARY KEY,
                title TEXT,
                body TEXT
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

  Future<void> savePodcast(Podcast podcast) async {
    final db = await openDb();
    await db.insert('podcasts', podcast.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> savePodcasts(List<Podcast> podcasts) async {
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
    final db = await openDb();

    final List<Map<String, dynamic>> queryRows = await db.query('podcasts');

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
  Future<List<Podcast>> getFavorites() async {
    final db = await openDb();
    final List<Map<String, dynamic>> queryRows = await db.query('favorites');

    if (queryRows.isNotEmpty) {
      return List.generate(queryRows.length, (index) {
        return Podcast.fromMap(queryRows[index]);
      });
    }

    return [];
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
  Future<void> saveFavorites(Podcast favorite) async {
    final db = await openDb();

    await db.insert('favorites', favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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
    if (queryRows.isNotEmpty) {
      return List.generate(queryRows.length, (index) {
        return Episode.fromMap(queryRows[index]);
      });
    }
    return [];
    // return queryRows.map((row) => Episode.fromMap(row)).toList();
  }

  ////////////////////////////////////////////////////////////////
  ////
  ///
  ///

  Future<void> saveEpisode(Episode episode) async {
    final db = await openDb();
    await db.insert('episodes', episode.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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
  Future<List<Funfact>> getFunfact() async {
    final db = await openDb();
    List<Map<String, dynamic>> result = await db.query(
      'funfacts', // Limit the query to retrieve only one row
    );
    if (result.isNotEmpty) {
      return List.generate(result.length, (index) {
        return Funfact.fromMap(result[index]);
      });
    }
    return [];
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
