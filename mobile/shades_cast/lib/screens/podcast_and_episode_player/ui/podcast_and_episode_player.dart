import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_player/bloc/episode_player_bloc.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_player/ui/episode_player.dart';
// import 'package:shades_cast/Infrustructure_layer/ui_components/episode_lister.dart';
import 'package:shades_cast/Infrustructure_layer/ui_components/episode_item.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PodcastPage extends StatefulWidget {
  final int podcastId;
  const PodcastPage({requiredthis.podcastId});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PodcastDetailsAndPlayerBloc,
            PodcastDetailsAndPlayerState>(
          builder: (context, state) {
            return (state is PodcastLoadingState)
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                    ),
                  )
                : Container(
                    height: double.infinity,
                    child: Column(children: [
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
                                        "Podcast Title",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400,
                                        ),
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
                                                style: TextStyle(fontSize: 20),
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
                                                  "Fkrnew Berhanu",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 15),
                                                color: Color.fromARGB(
                                                    155, 129, 107, 43),
                                                child: Text(
                                                  "Firaol Ibrahim",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              )
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
                            audioUrls: (state is PodcastDetailEpisodes)
                                ? state.audioUrls
                                : [''],
                            currentEpisodeIndex:
                                (state is PodcastDetailEpisodes)
                                    ? state.currentPlayingEpisode
                                    : 0),
                      ),

                      Container(
                        width: double.infinity,
                        color: Color.fromARGB(45, 47, 47, 47),
                        margin: EdgeInsets.only(bottom: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 30,
                              color: Color.fromARGB(255, 210, 210, 210),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "Episode ${(state is PodcastDetailEpisodes) ? (state.currentPlayingEpisode % (state.audioUrls.length) + 1) : 1}",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "The Big Oxmox advised her not to do so, because there were thousands of bad Commas, wild Question Marks and devious Semikoli, but the Little Blind Text didn't listen. ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 170, 170, 170)),
                        ),
                      ),
                      //description component,
                      (state is PodcastDetailEpisodes)
                          ? getEpisodes(episodes: state.episodes, state: state)
                          : getEpisodes(
                              episodes: [], state: state, context: context),
                    ]),
                  );
          },
        ),
      ),
    );
  }
}

Widget getEpisodes({required List<EpisodeItem> episodes, state, context}) {
  if (!(state is PodcastDetailEpisodes)) {
    BlocProvider.of<PodcastDetailsAndPlayerBloc>(context)
        .add(EpisodeItemClicked(selectedIndex: 0, podcastId: 2));
  }
  return Expanded(
      child: ListView(
    children: episodes,
  ));
}
