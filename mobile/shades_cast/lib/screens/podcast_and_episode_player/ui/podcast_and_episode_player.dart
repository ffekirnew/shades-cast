import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_player/bloc/episode_player_bloc.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_player/ui/episode_player.dart';
// import 'package:shades_cast/Infrustructure_layer/ui_components/episode_lister.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/domain_layer/episode.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shades_cast/screens/add_epsiode/ui/addEpisode.dart';

class PodcastPage extends StatefulWidget {
  final int podcastId;
  const PodcastPage({required this.podcastId});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(215, 20, 20, 20),
      body: BlocBuilder<PodcastDetailsAndPlayerBloc,
          PodcastDetailsAndPlayerState>(
        builder: (context, state) {
          if (state is PodcastDetailsAndPlayerErrorState) {
            return Center(
              child: Container(
                  width: 300,
                  height: 100,
                  child: Text(
                    "Error Getting Podcast. Try again",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
            );
          }
          return (!(state is PodcastDetailEpisodes))
              ? Center(
                  child: SpinKitFadingCircle(
                    color: Color.fromARGB(255, 37, 153, 255),
                  ),
                )
              : Container(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        color: Color.fromARGB(255, 0, 0, 0),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image(
                              image: AssetImage('Assets/images/podcast_bg.png'),
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                            Container(
                              width: double.infinity,
                              height: 250,
                              color: Color.fromARGB(215, 20, 20, 20),
                            ),
                            Container(
                              height: 250,
                              width: double.infinity,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        state.podcast.title,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Column(
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 25),
                                              child: Text(
                                                "Creators",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 15),
                                                color: Color.fromARGB(
                                                    155, 129, 107, 43),
                                                child: Text(
                                                    state.podcast.author ?? "",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150,
                        child: EpisodePlayer(
                            episodes: state.episodes,
                            currentEpisodeIndex: state.currentPlayingEpisode),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        height: ((state.podcast.description != null) |
                                (state.episodes.length == 0))
                            ? 90
                            : 0,
                        child: ListView(children: [
                          Text(
                            state.podcast.description ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ]),
                      ),
                      (state.episodes.length > 0)
                          ? Container(
                              width: double.infinity,
                              color: Color.fromARGB(44, 255, 255, 255),
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      state
                                          .episodes[state.currentPlayingEpisode]
                                          .title,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      (state.episodes.length > 0)
                          ? getEpisodes(
                              episodes: state.episodes,
                              state: state,
                              podcastId: widget.podcastId)
                          : Container(
                              margin: EdgeInsets.only(bottom: 250),
                              child: Center(
                                child: Text(
                                  "No Episodes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: BlocBuilder<PodcastDetailsAndPlayerBloc,
          PodcastDetailsAndPlayerState>(builder: (context, state) {
        int podcastId = 1;
        if (state is PodcastDetailEpisodes) {
          podcastId = state.podcast.id;
        }
        return (state.isFromMyPodcasts)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEpisodeScreen(
                              podcastId: podcastId,
                              refresh: true,
                            )),
                  );
                },
                child: Icon(Icons.add),
              )
            : Container();
      }),
    ));
  }
}

Widget getEpisodes(
    {required List<Episode> episodes,
    required state,
    context,
    required int podcastId}) {
  List<EpisodeItem> episodeItems = [];
  for (int index = 0; index < episodes.length; index++) {
    print(state.currentPlayingEpisode);
    print(index);

    print(state.isFromMyPodcasts);
    episodeItems.add(EpisodeItem(
        episodes[index], (state.currentPlayingEpisode == index), index,
        episodeId: episodes[index].id, dispayDelete: (state.isFromMyPodcasts)));
  }

  return Expanded(
      child: ListView(
    children: episodeItems,
  ));
}
