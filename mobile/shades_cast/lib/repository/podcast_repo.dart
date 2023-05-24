// import 'dart:convert';

// import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
// import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
// import 'package:shades_cast/domain_layer/podcast.dart';

// class PodcastRepo {
//   Future<List<Podcast>> getPodcasts(
//       {required PodcastApiClient podcastClient}) async {
//     List podcastsRecieved;
//     try {
//       podcastsRecieved = await podcastClient.getPodcasts();
//       print('podcast recieve in repo');
//     } catch (e) {
//       print(e);
//       throw Exception("cannot get podcasts");
//     }
//     List<Podcast> podcasts = [];

//     for (final podcast in podcastsRecieved) {
//       // Map<String, dynamic> json = podcast;
//       print(podcast);
//       Podcast curPodcast = Podcast.fromJson(podcast);
//       podcasts.add(curPodcast);
//     }
//     print(podcasts);
//     return podcasts;
//   }

//   Future<List<EpisodeItem>> getEpisodes(
//       {required int selectedIndex, int podcastId = 0}) async {
//     List<String> episodesSrcs = await getEpisodeSrcs();
//     List<EpisodeItem> episodes = [];
//     if (selectedIndex < 0) {
//       selectedIndex = episodesSrcs.length - 1;
//     }
//     for (int i = 0; i < episodesSrcs.length; i++) {
//       episodes.add(
//         EpisodeItem(
//           name: 'Episode ${i + 1}',
//           duration: Duration(seconds: i, hours: 2, minutes: 32),
//           isSelected: (i == (selectedIndex % episodesSrcs.length)),
//           myIndex: i,
//         ),
//       );
//     }

//     return episodes;
//   }

// //dummy data for testing
//   Future<List<String>> getEpisodeSrcs() async {
//     await Future.delayed(Duration(seconds: 0));
//     return [
//       'https://fikernewapi.pythonanywhere.com/media/the-daily-show/2023/04/13/545d7084-ad84-4878-b849-fb6e5217a2e3.mp3',
//       "https://fikernewapi.pythonanywhere.com/media/the-daily-show/2023/04/13/545d7084-ad84-4878-b849-fb6e5217a2e3.mp3",
//       "https://fikernewapi.pythonanywhere.com/media/the-daily-show/2023/04/13/545d7084-ad84-4878-b849-fb6e5217a2e3.mp3"
//     ];
//   }

//   Future<Map> getPodcast({podcastId}) async {
//     PodcastApiClient podcastService = PodcastApiClient();
//     String res = await podcastService.getSinglePodcast(podcastId: 1);
//     print('in podcast');
//     print(res);
//     Map map = {};
//     if (res != 'no data') {
//       map = {
//         'id': jsonDecode(res)['id'],
//         'title': jsonDecode(res)['title'],
//         'author': jsonDecode(res)['author'],
//         'description': jsonDecode(res)['description'],
//         'imageUrl': jsonDecode(res)['imageUrl'],
//         'category': jsonDecode(res)['category'],
//       };
//     }
//     return map;
//   }
// }
