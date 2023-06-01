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
import 'package:shades_cast/screens/my_podcasts/bloc/my_podcasts_bloc.dart';

class MyPodcastsPage extends StatefulWidget {
  bool refresh;
  MyPodcastsPage({this.refresh = false});

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
        body: BlocBuilder<MyPodcastsBloc, MyPodcastsState>(
          builder: (context, state) {
            if (widget.refresh) {
              BlocProvider.of<MyPodcastsBloc>(context).add(GetMyPodcasts());
              widget.refresh = false;
            }
            if (state is MyPodcastsInitial) {
              BlocProvider.of<MyPodcastsBloc>(context).add(GetMyPodcasts());
            } else if (state is MyPodcastErrorState) {
              return Padding(
                padding: EdgeInsets.only(left: 13, right: 13, top: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "My Podcasts",
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Color.fromARGB(255, 49, 217, 255),
                              size: 25,
                            ),
                            onPressed: () {
                              BlocProvider.of<MyPodcastsBloc>(context)
                                  .add(GetMyPodcasts());
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "An error occured",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: Color.fromARGB(255, 49, 217, 255),
                              size: 30,
                            ),
                            onPressed: () {
                              BlocProvider.of<MyPodcastsBloc>(context)
                                  .add(GetMyPodcasts());
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            // BlocProvider.of<MyPodcastsBloc>(context).add(GetPodcasts());
            return Padding(
              padding: EdgeInsets.only(left: 13, right: 13, top: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "My Podcasts",
                          style: TextStyle(
                            color: Colors.grey[100],
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Color.fromARGB(255, 49, 217, 255),
                            size: 25,
                          ),
                          onPressed: () {
                            BlocProvider.of<MyPodcastsBloc>(context)
                                .add(GetMyPodcasts());
                          },
                        )
                      ],
                    ),
                  ),
                  (state is MyPodcastLoadedState)
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
      print(currentPodcast.imageUrl);
      print(currentPodcast.description);
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
          BlocProvider.of<PodcastDetailsAndPlayerBloc>(context).add(
              PodcastDetailPageOpened(
                  podcastId: currentPodcast.id, isFromMyPodcasts: true));
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
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteConfirmationDialog(
                          onConfirm: () {
                            BlocProvider.of<MyPodcastsBloc>(context).add(
                                PodcastDeleted(podcastId: currentPodcast.id));
                          },
                        );
                      },
                    );
                  },
                ),
                // trailing: IconButton(
                //   onPressed: () {
                //     BlocProvider.of<MyPodcastsBloc>(context)
                //         .add(PodcasMyd(podcastId: currentPodcast.id));
                //   },
                //   icon: Icon(
                //     (widget.currentState.MydPodcastId
                //             .contains(currentPodcast.id))
                //         ? Icons.My
                //         : Icons.My_border,
                //     color: Color.fromARGB(255, 71, 160, 255),
                //     size: 25,
                //   ),
                // ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                child: Text(
                  currentPodcast.description ?? "",
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

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteConfirmationDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to delete?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
