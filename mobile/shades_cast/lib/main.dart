import 'package:flutter/material.dart';
import 'package:shades_cast/screens/myPodcasts.dart';
import 'screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'screens/addEpisode.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final PodcastApiClient podcastApiClient = PodcastApiClient(
    httpClient: http.Client(),
  );

  @override
  Widget build(BuildContext context) {
    return AddEpisodeScreen();
  }
}

//the widget i used to test the services i wrote
class testWidget extends StatelessWidget {
  const testWidget({
    super.key,
    required this.podcastApiClient,
  });

  final PodcastApiClient podcastApiClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podcasts App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Podcasts'),
        ),
        body: Center(
          child: FutureBuilder<List<dynamic>>(
            future: podcastApiClient.getPodcasts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data.runtimeType);
                final podcasts = snapshot.data!;
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(podcasts[index]["cover_image"]),
                        subtitle: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              podcasts[index]["cover_image"],
                            )));
                  },
                );
              } else if (snapshot.hasError) {
                print('${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
