import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain_layer/podcast.dart';
import 'constants.dart';

class PodcastApiClient {
  late final http.Client httpClient;

  PodcastApiClient({required this.httpClient});

  //method to return all the podcasts
  Future<List<dynamic>> getPodcasts() async {
    final response = await httpClient.get(Uri.parse('$api/api/podcasts'));
    //inspect the response
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    print(jsonDecode(response.body).runtimeType);

    return jsonDecode(response.body);
  }

  //method to handle searching of a podcast
  Future<List<dynamic>> searchPodcasts(String query) async {
    final response = await httpClient.get(Uri.parse('$api/search?q=$query'));
    if (response.statusCode == 200) {
      final podcastsJson = json.decode(response.body)['results'];
      return podcastsJson.map<Podcast>((json)).toList();
    } else {
      throw Exception('Failed to load podcasts');
    }
  }

  //method to handle the delation of a specific podcast by using its ID
  Future<void> deletePodcastById(String podcastId) async {
    final url = '$api/podcasts/$podcastId';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete podcast with ID $podcastId');
    }
  }
}
