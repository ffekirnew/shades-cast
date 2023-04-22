import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class PodcastApiClient {
  late final http.Client httpClient;

  PodcastApiClient({required this.httpClient});

  //method to return all the podcasts
  Future<String> getPodcasts() async {
    final response = await httpClient.get(Uri.parse('$api/api/podcasts'));
    //inspect the response
    print('made the call');
    if (response.statusCode != 200) {
      return "no data";
    }
    return jsonDecode(response.body).join(", ");
  }

  //
}

// void main(List<String> args) async {
//   print('got here');
//   final PodcastApiClient client = PodcastApiClient();
//   var res = await client.getPodcasts();
//   print(res);
// }
