import 'package:flutter/material.dart';
import 'package:shades_cast/screens/add_podcast/ui/addPodcast.dart';
import '../../add_podcast/ui/addPodcast.dart';

import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';
import '../../settings/ui/settings.dart';
import '../../my_podcasts/ui/myPodcasts.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyPodcastsPage extends StatefulWidget {
  MyPodcastsPage();

  @override
  _MyPodcastsPageState createState() => _MyPodcastsPageState();
}

class _MyPodcastsPageState extends State<MyPodcastsPage> {
  @override
  void initState() {
    super.initState();
    _loadPodcasts();
  }

  void _loadPodcasts() async {
    setState(() {});
  }

  void _navigateToAddPodcast() async {
    final result = await Navigator.pushNamed(context, '/add_podcast');
    if (result == true) {
      _loadPodcasts();
    }
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
          title: Text('My Podcasts'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (!(state is PodcastLoadedState)) {
              BlocProvider.of<HomeBloc>(context).add(GetPodcasts());
            }
            // BlocProvider.of<HomeBloc>(context).add(GetPodcasts());
            return Padding(
              padding: EdgeInsets.only(left: 13, right: 13, top: 40),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Podcasts",
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  (state is PodcastLoadedState)
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addPodcasts()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class demo extends StatelessWidget {
  final String coverImage;
  final String title;
  final String category;
  final int episodes;
  const demo(
      {super.key,
      required this.coverImage,
      required this.title,
      required this.category,
      required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              "$coverImage",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "$category",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "$episodes episodes",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class podcastList extends StatefulWidget {
  List<dynamic> podcasts;
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
                      "https://fikernewapi.pythonanywhere.com/media/the-daily-show/cover-images/d0260764-4aae-4180-8c49-0b6110c877f9.jpg"), //dummy image for place holder if no image
                ),
                title: Text(
                  currentPodcast.title,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(PodcasFavorited(podcastId: currentPodcast.id));
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