import 'package:flutter/material.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';

class FavoritePodcastsPage extends StatefulWidget {
  FavoritePodcastsPage();

  @override
  _FavoritePodcastsPageState createState() => _FavoritePodcastsPageState();
}

class _FavoritePodcastsPageState extends State<FavoritePodcastsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Color(0xFF081624),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
              color:
                  Color.fromARGB(55, 255, 255, 255)), // set the text color here
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF081624),
          title: Text('Favorite Podcasts'),
        ),
        body: BlocBuilder<FavoritePodcastsBloc, FavoritePodcastsState>(
          builder: (context, state) {
            if (!(state is FavPodcastLoadedState)) {
              BlocProvider.of<FavoritePodcastsBloc>(context)
                  .add(GetFavPodcasts());
            }
            // BlocProvider.of<FavoritePodcastsBloc>(context).add(GetPodcasts());
            return Padding(
              padding: EdgeInsets.only(left: 13, right: 13, top: 40),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Favorite Podcasts",
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  (state is FavPodcastLoadedState)
                      ? Expanded(
                          child: podcastList(
                            podcasts: state.podcasts,
                            currentState: state,
                          ),
                        )
                      : Expanded(
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Color.fromARGB(255, 37, 153, 255),
                            ),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class podcastList extends StatefulWidget {
  final List<dynamic> podcasts;
  final currentState;

  podcastList({required this.podcasts, required this.currentState});

  @override
  State<podcastList> createState() => _podcastListState();
}

class _podcastListState extends State<podcastList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> podcasts = [];

    for (int index = 0; index < widget.podcasts.length; index++) {
      Podcast currentPodcast = widget.podcasts[index];

      podcasts.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PodcastPage(podcastId: currentPodcast.id)));
          //   BlocProvider.of<PodcastDetailsAndPlayerBloc>(context).add(
          //       EpisodeItemClicked(
          //           selectedIndex: currentPodcast.id,
          //           podcastId: currentPodcast.id));
          BlocProvider.of<PodcastDetailsAndPlayerBloc>(context)
              .add(PodcastDetailPageOpened(podcastId: currentPodcast.id));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          color: Color.fromARGB(255, 0, 0, 0),
          child: Column(
            children: [
              ListTile(
                leading: Image(
                  image: NetworkImage(currentPodcast.imageUrl ??
                      "https://fikernewapi.pythonanywhere.com/media/the-daily-show/cover-images/d0260764-4aae-4180-8c49-0b6110c877f9.jpg"), //dumFavorite image for place holder if no image
                ),
                title: Text(
                  currentPodcast.title,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    BlocProvider.of<FavoritePodcastsBloc>(context)
                        .add(FavPodcastFavorited(podcastId: currentPodcast.id));
                  },
                  icon: Icon(
                    (widget.currentState.favoritedPodcastId
                            .contains(currentPodcast.id))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Color.fromARGB(255, 71, 160, 255),
                    size: 25,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                child: Text(
                  //  currentPodcast.description ?? "",
                  "some description to check how the subtitle exactly looks and if it can be used",
                  style: TextStyle(
                      color: Color.fromARGB(205, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListView(
        padding: EdgeInsets.zero,
        children: podcasts,
      ),
    );
  }
}
