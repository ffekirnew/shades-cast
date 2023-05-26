import 'dart:async';

import 'podcast.dart';
import 'api_infrastructure.dart';
import 'infrastructure.dart';
// import '../authService.dart';

class FavoritePodcastsBloc {
  final _podcastsController = StreamController<List<Podcast>>();
  final _favoritesController = StreamController<List<Podcast>>.broadcast();

  List<Podcast> _podcasts = [];
  List<Podcast> _favoritePodcasts = [];

  Stream<List<Podcast>> get podcastsStream => _podcastsController.stream;
  Stream<List<Podcast>> get favoritesStream => _favoritesController.stream;

  // final AuthService _authService = AuthService(); // Create an instance of AuthService

  // Fetch podcasts from the API
  Future<void> fetchPodcasts() async {
    try {
      _podcasts = await DataBase.database!.getFavorites();
      if (_podcasts.isEmpty) {
        // final token = await _authService.getToken();
        _podcasts = await FavoriteApi.fetchFavorites(token);
      }
      _podcastsController.sink.add(_podcasts);
    } catch (e) {
      _podcastsController.addError(e);
    }
  }

  Future<void> removeFromFavorites(Podcast podcast) async {
    await DataBase.database!.removeFavoritePodcast(podcast.id);
    _favoritePodcasts.remove(podcast);
    _favoritesController.sink.add(_favoritePodcasts);
  }

  void dispose() {
    _podcastsController.close();
    _favoritesController.close();
  }
}
