import 'dart:ffi';

import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/episode.dart';

class PodcastDatabase {
  static final PodcastDatabase instance = PodcastDatabase._init();
  static Database? _database;

  PodcastDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('podcasts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE podcasts(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        author TEXT,
        imageUrl TEXT,
        categories TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE episodes(
        id TEXT PRIMARY KEY,
        podcastId TEXT,
        title TEXT,
        description TEXT,
        audioUrl TEXT
      )
      ''');
    await db.execute('''
    CREATE TABLE favorites(
     id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        author TEXT,
        cover_image TEXT,
        categories TEXT
    )
''');
    // await db.execute('''
    //   CREATE TABLE funfacts(
    //     TEXT title,
    //     TEXT body
    //   )
    //     ''');
  }

  ////////////////////////////////
  ///
  ///
  ///

  Future<void> savePodcast(dynamic podcast) async {
    final db = await instance.database;
    // print((podcast.toMap()['id'].runtimeType));
    print('eheheeeheheheheh');
    // await db.insert('podcasts', podcast.toMap());
    // print('got here safe saya');
    var podcasts = podcast;
    print('open road');
    print(podcasts);
    String id = podcasts["id"].toString();
    String title = podcasts["title"];
    String description = podcasts["description"];
    String author = 'null';
    print('did the first'); // Assuming the "id" value is already an integer
    String imageUrl = podcasts["cover_image"];
    String categories = podcasts["categories"][0];

    // Use the correct data types in the SQL INSERT statement
    String insertQuery =
        'INSERT INTO podcasts (id, title, description, author, imageUrl, categories) '
        'VALUES (?, ?, ?, ?, ?, ?)';
    List<dynamic> insertArgs = [
      id,
      title,
      description,
      author,
      imageUrl,
      categories
    ];

    // Execute the SQL INSERT statement
    await db.rawInsert(insertQuery, insertArgs);
    // var rres = await getPodcasts();
    // // Podcast.fromMap(rres[25]);
    // print(rres);
  }

////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> savePodcasts(List<dynamic> podcasts) async {
    final db = await instance.database;
    for (Podcast podcast in podcasts) {
      await db.insert('podcasts', podcast.toMap());
    }
  }

  Future<void> deletePodcast(String podcastId) async {
    final db = await instance.database;
    await db.delete('podcasts', where: 'id = ?', whereArgs: [podcastId]);
  }

////////////////////////////////////////////////
  ///
  ///
  ///
  Future<Podcast?> getPodcastById(String podcastId) async {
    final db = await instance.database;
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
    print('heerrrrrrrrrrrro');
    final db = await instance.database;
    final List<Map<String, Object?>> queryRows = await db.query('podcasts');
    final List<dynamic> maps = queryRows.map((row) => row).toList();
    // return maps;
    // return maps;
    final res = List.generate(maps.length, (index) {
      return Podcast.fromMap(maps[index]);
    });
    print(res);
    return res;
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  Future<List<Podcast>?> getFavorites() async {
    final db = await instance.database;
    final maps = await db.query('favorites');
    return List.generate(maps.length, (index) {
      return Podcast.fromMap(maps[index]);
    });
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> saveFavorites(List<Podcast> favorites) async {
    final db = await instance.database;
    for (Podcast podcast in favorites) {
      await db.insert('favorites', podcast.toMap());
    }
  }

  Future<void> saveEpisodes(List<Episode> episodes) async {
    final db = await instance.database;
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
    final db = await instance.database;
    final maps = await db
        .query('episodes', where: 'podcastId = ?', whereArgs: [podcastId]);
    return List.generate(maps.length, (index) {
      return Episode.fromMap(maps[index]);
    });
  }

  ////////////////////////////////////////////////////////////////
  ////
  ///
  ///

  Future<void> saveEpisode(Episode episode) async {
    final db = await instance.database;
    db.insert('episodes', episode.toMap());
  }

////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<void> deleteEpisode(String podcastId, Episode episode) async {
    final db = await instance.database;
    db.delete('episodes', where: 'id =?', whereArgs: [episode.id]);
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  Future<Funfact?> getFunfact() async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'funfacts',
      limit: 1, // Limit the query to retrieve only one row
    );
    if (result.length > 0) {
      return Funfact.fromMap(result.first);
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////
  ///
  ///
  Future<void> saveFunfact(Funfact funfact) async {
    final db = await instance.database;
    await db.insert('funfacts', funfact.toMap());
  }
}
