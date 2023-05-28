import 'dart:io';
import 'package:path/path.dart' as path;

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
  final AuthService authService = AuthService();

  PodcastApiClient();

  //method to return all the podcasts
  //////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  Future<List<dynamic>> getPodcasts() async {
    final response = await http.get(Uri.parse('$api/api/v2/podcasts'));

    //inspect the response

    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    // print(jsonDecode(response.body).runtimeType);

    return jsonDecode(response.body);
  }

  //method to return my podcasts
  //////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  Future<List<dynamic>> getMyPodcasts() async {
    final response =
        await http.get(Uri.parse('$api/api/v2/podcasts/podcasts-created'));
    //inspect the response

    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    // print(jsonDecode(response.body).runtimeType);
    // print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  //method to handle searching of a podcast
  /////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<List<dynamic>> searchPodcasts(String query) async {
    final response = await http.get(Uri.parse('$api/search?q=$query'));
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
    final response = await http.get(Uri.parse('$api/api/v2/podcasts/' + id));

    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    return jsonDecode(response.body);
  }

  /////////////////////method to handle favorite podcasts
  ///
  ///
  ///
  ///
  Future<dynamic> favoritePodcasts() async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }

    Map<String, String> headers = {'Authorization': 'Token $token'};
    final response = await http.get(
      Uri.parse('$api/api/v2/podcasts-favorited'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    print("api called successfully");
    return jsonDecode(response.body);
  }

  /////////////////////method to handle favorite podcasts
  ///
  ///
  ///
  ///
  Future<dynamic> myPodcasts() async {
    String? token = await authService.getToken();
    if (token == null) {
      throw Exception("cannot get token");
    }

    Map<String, String> headers = {'Authorization': 'Token $token'};
    final response = await http.get(
      Uri.parse('$api/api/v2/podcasts-created'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      throw Exception("cannot get podcasts");
    }
    print("api called successfully");
    return jsonDecode(response.body);
  }

  //method to add a new podcast
  //////////////////////////////////
  ///
  ///
  ///
  ///
  Future<dynamic> addPodcast(dynamic podcast) async {
    File _imageFile = podcast["cover_image"];
    String title = podcast["title"];
    String description = podcast["description"];
    String categories = podcast["categories"];

    // String? token = await authService.getToken();
    // print("api called successfully");
    // print(token);
    // if (token == null) {
    //   throw Exception("cannot get token");
    // }
    // print(podcast);
    // Map<String, String> headers = {'Authorization': 'Token $token'};
    // final response = await http.post(
    //   Uri.parse('$api/api/v2/podcasts/'),
    //   body: podcast,
    //   headers: headers,
    // );
    // print("got here");
    // print(response.statusCode);
    // print(jsonDecode(response.body));

    final AuthService authService = AuthService();

    var stream = http.ByteStream(_imageFile.openRead());
    stream.cast();
    var length = await _imageFile.length();
    var uri = Uri.parse('http://192.168.0.144:8000/api/v2/podcasts/');
    var request = http.MultipartRequest('POST', uri);
    String? token = await authService.getToken();

    request.headers['Authorization'] = 'Token $token';
    request.fields['title'] = title;
    request.fields['categories'] = categories;

    var multipartFile = http.MultipartFile(
      'cover_image',
      stream,
      length,
      filename: path.basename(_imageFile.path), // Use the original filename
    );
    request.files.add(multipartFile);
    request.fields['cover_image'] = path.basename(_imageFile.path);

    try {
      var response = await request.send();
      if (response.statusCode != 200) {
        print((response.statusCode));
        print("Error sending the file");
      } else {
        print('Success');
      }
    } catch (e) {
      print("Error: $e");
    }
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
    final response = await http.delete(
      Uri.parse('$api/api/podcasts/' + podcastId),
      headers: headers,
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete podcast with ID $podcastId');
    }
    return jsonDecode(response.body);
  }

  //////////////////Method that handles the search of episodes of a podcast
  ///
  ////////////
  ///
  ///

  Future<dynamic> getEpisodes(String podcatId) async {
    // .....................has to be commented back...................
    String? token = await authService.getToken();
    print("in here get episodes");
    if (token == null) {
      throw Exception("cannot get token");
    }
    Map<String, String> headers = {
      'Authorization': 'Bearer $token'
    }; //podcasts/{id}/episodes
    final response =
        await http.get(Uri.parse("$api/api/v2/podcasts/2/episodes"));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to get podcast with ID $podcatId');
    } else {
      return json.decode(response.body);
    }
  }

  Future<void> addEpisode(dynamic episode) async {
    File _audioFile = episode["_audioFile"];
    String title = episode["title"];
    String description = episode["description"];
    String id = episode["podcast"];
    var uri = Uri.parse('$api/api/v2/episodes/');
    var request = http.MultipartRequest('POST', uri);
    final AuthService authService = AuthService();
    String? token = await authService.getToken();

    request.headers['Authorization'] = 'Token $token';
    request.fields['title'] = title;
    request.fields['tags'] = description;
    request.fields['podcast'] = id;

    if (_audioFile != null) {
      var stream = http.ByteStream(_audioFile.openRead());
      stream.cast();
      var length = await _audioFile.length();

      var multipartFile = http.MultipartFile(
        'audio_file',
        stream,
        length,
        filename: path.basename(_audioFile.path),
      );

      request.files.add(multipartFile);

      try {
        var response = await request.send();
        if (response.statusCode != 200) {
          print((response.statusCode));
          print("Error sending the file");
        } else {
          print('Success');
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("No audio file selected");
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

    final response = await http.delete(
      Uri.parse('$api/api/episodes'),
      body: episode,
      headers: headers,
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete episode');
    }
  }
}



  //method to add a new podcast
  //////////////////////////////////
  ///
  ///
  ///
  ///
  // Future<dynamic> addPodcast(dynamic podcast) async {
  //   String? token = await authService.getToken();
  //   if (token == null) {
  //     throw Exception("cannot get token");
  //   }
  //   Map<String, String> headers = {'Authorization': 'Bearer $token'};
  //   final response = await http.post(
  //     Uri.parse('$api/api/podcasts'),
  //     body: podcast,
  //     headers: headers,
  //   );
  // }

  //method to handle the deletion of a specific podcast by using its ID
  //////////////////////////////////
  ///
  ///
  ///
  // Future<void> deletePodcast(String podcastId) async {
  //   String? token = await authService.getToken();
  //   if (token == null) {
  //     throw Exception("cannot get token");
  //   }
  //   Map<String, String> headers = {'Authorization': 'Bearer $token'};
  //   final response = await http.delete(
  //     Uri.parse('$api/api/podcasts/' + podcastId),
  //     headers: headers,
  //   );

  //   if (response.statusCode != 204) {
  //     throw Exception('Failed to delete podcast with ID $podcastId');
  //   }
  // }

  ////////////////////////////////
  ///
  ///
  ///
