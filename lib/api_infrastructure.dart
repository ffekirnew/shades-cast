// infrastructure with the api

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'podcast.dart';

class FavoriteApi {
  static const baseUrl = ''; // baseUrl to be filled

  static Future<List<Podcast>> fetchFavorites(Map<String, String> token) async {
    final response =
        await http.get(Uri.parse('$baseUrl/favorites'), headers: token);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Podcast> podcasts = [];
      for (var podcastData in data) {
        final podcast = Podcast.fromJson(podcastData);
        podcasts.add(podcast);
      }
      return podcasts;
    } else {
      throw Exception('Failed to fetch podcasts');
    }
  }
}
