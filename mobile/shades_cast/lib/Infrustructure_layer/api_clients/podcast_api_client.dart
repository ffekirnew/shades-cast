import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

class PodcastApiClient {
  PodcastApiClient();

  //method to return all the podcasts
  // Future<String> getPodcasts() async {
  //   final response = await http.get(Uri.parse('$api/api/podcasts/'));
  //   //inspect the response
  //   print('made the call');
  //   if (response.statusCode != 200) {
  //     return "no data";
  //   }
  //   return jsonDecode(response.body).join(", ");
  // }

  //method to return all the podcasts
  Future<List> getPodcasts() async {
    final response =
        await http.get(Uri.parse('$api/api/v2/podcasts/?format=json'));
    //inspect the response
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts here in api lient");
    }
    print(jsonDecode(response.body).runtimeType);
    print("in pod api");
    // print(response.body);
    return jsonDecode(response.body);
  }

  Future<String> getSinglePodcast({podcastId}) async {
    final response = await http.get(Uri.parse('$api/api/podcasts/$podcastId/'));
    if (response.statusCode != 200) {
      print('single podcast fetching unsuccessful');
      return "no data";
    }

    print('podcast fetching successful');
    print(jsonDecode(response.body).join(", "));
    return jsonDecode(response.body).join(", ");
  }

  //foraol's
  //method to handle searching of a podcast
  Future<List<dynamic>> searchPodcasts(String query) async {
    final response = await http.get(Uri.parse('$api/search?q=$query'));
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



// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../domain_layer/podcast.dart';
// import 'constants.dart';

// class PodcastApiClient {
//   late final http.Client http;

//   PodcastApiClient({required this.http});

//   //method to return all the podcasts
//   Future<List<dynamic>> getPodcasts() async {
//     final response = await http.get(Uri.parse('$api/api/podcasts'));
//     //inspect the response
//     if (response.statusCode != 200) {
//       throw Exception("cannot get podcasts");
//     }
//     print(jsonDecode(response.body).runtimeType);

//     return jsonDecode(response.body);
//   }

//   //method to handle searching of a podcast
//   Future<List<dynamic>> searchPodcasts(String query) async {
//     final response = await http.get(Uri.parse('$api/search?q=$query'));
//     if (response.statusCode == 200) {
//       final podcastsJson = json.decode(response.body)['results'];
//       return podcastsJson.map<Podcast>((json)).toList();
//     } else {
//       throw Exception('Failed to load podcasts');
//     }
//   }

//   //method to handle the delation of a specific podcast by using its ID
//   Future<void> deletePodcastById(String podcastId) async {
//     final url = '$api/podcasts/$podcastId';

//     final response = await http.delete(Uri.parse(url));

//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete podcast with ID $podcastId');
//     }
//   }
// }
