import 'package:http/http.dart' as http;
import 'package:shades_cast/domain_layer/episode.dart';
import 'dart:convert';
import '../../domain_layer/podcast.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

class PodcastApiClient {
  late final http.Client httpClient;
  final AuthService authService = AuthService();

  PodcastApiClient({required this.httpClient});

  //method to return all the podcasts
  //////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  Future<List<dynamic>> getPodcasts() async {
    final response = await httpClient.get(Uri.parse('$api/api/podcasts'));
    //inspect the response
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    // print(jsonDecode(response.body).runtimeType);

    return jsonDecode(response.body);
  }

  //method to handle searching of a podcast
  /////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<List<dynamic>> searchPodcasts(String query) async {
    final response = await httpClient.get(Uri.parse('$api/search?q=$query'));
    if (response.statusCode == 200) {
      final podcastsJson = json.decode(response.body)['results'];
      return podcastsJson.map<Podcast>((json)).toList();
    } else {
      throw Exception('Failed to load podcasts');
    }
  }

  //method to handle seaching podcasts by id
  ///////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<dynamic> getPodcastById(String id) async {
    final response = await httpClient.get(Uri.parse('$api/api/podcasts/' + id));
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    return jsonDecode(response.body);
  }

  //method to add a new podcast
  //////////////////////////////////
  ///
  ///
  ///
  ///
  Future<dynamic> addPodcast(dynamic podcast) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await httpClient.post(
      Uri.parse('$api/api/podcasts'),
      body: podcast,
      headers: headers,
    );
  }

  //method to handle the deletion of a specific podcast by using its ID
  //////////////////////////////////
  ///
  ///
  ///
  Future<void> deletePodcast(String podcastId) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await httpClient.delete(
      Uri.parse('$api/api/podcasts/' + podcastId),
      headers: headers,
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete podcast with ID $podcastId');
    }
  }
  ////////////////////////////////
  ///
  ///
  ///

  Future<void> addEpisode(String podcastId, Episode episode) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await httpClient.post(
      Uri.parse('$api/api/episodes'),
      body: episode,
      headers: headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add episode with');
    }
  }

  /////////////////////////////
  ///
  ///
  ///
  Future<void> deleteEpisode(String podcastId, Episode episode) async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await httpClient.delete(
      Uri.parse('$api/api/episodes'),
      body: episode,
      headers: headers,
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete episode');
    }
  }
}
