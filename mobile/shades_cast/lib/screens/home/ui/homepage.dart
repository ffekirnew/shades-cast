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
import 'package:shades_cast/screens/favorite_podcasts/ui/favorite_podcasts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatelessWidget {
  homepage({super.key});
  final PodcastApiClient podcastApiClient = PodcastApiClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          scaffoldBackgroundColor: Color(0xFF081624),
          textTheme: TextTheme(
            bodyMedium:
                TextStyle(color: Colors.white), // set the text color here
          ),
        ),
        child: Scaffold(
          drawer: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return sideMenu(
                state: state,
              );
            },
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              print(state);
              if (state is HomeInitial) {
                BlocProvider.of<HomeBloc>(context).add(GetPodcasts());
              } else if (state is PodcastsErrorState) {
                return Padding(
                  padding: EdgeInsets.only(left: 13, right: 13, top: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: AssetImage(
                                'Assets/images/podcast.png'), // add the image asset here
                            height: 50, // set the height here
                            width: 50, // set the width here
                            fit: BoxFit.contain, // set the BoxFit property here
                          ),
                          IconButton(
                            icon: Icon(Icons.menu),
                            color: Colors.white, // add the menu icon here
                            onPressed: () {
                              print("it was pressed");
                              Scaffold.of(context).openDrawer();
                              // add the onPressed callback here
                            },
                          )
                        ],
                      ),
                      searchBox(),
                      funFact(state: state),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Listen to Podcasts",
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
                                BlocProvider.of<HomeBloc>(context)
                                    .add(GetPodcasts());
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.refresh,
                                color: Color.fromARGB(255, 49, 217, 255),
                                size: 30,
                              ),
                              onPressed: () {
                                BlocProvider.of<HomeBloc>(context)
                                    .add(GetPodcasts());
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              // BlocProvider.of<HomeBloc>(context).add(GetPodcasts());
              return Padding(
                padding: EdgeInsets.only(left: 13, right: 13, top: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage(
                              'Assets/images/podcast.png'), // add the image asset here
                          height: 50, // set the height here
                          width: 50, // set the width here
                          fit: BoxFit.contain, // set the BoxFit property here
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white, // add the menu icon here
                          onPressed: () {
                            print("it was pressed");
                            Scaffold.of(context).openDrawer();
                            // add the onPressed callback here
                          },
                        )
                      ],
                    ),
                    searchBox(),
                    funFact(state: state),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Listen to Podcasts",
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
                              BlocProvider.of<HomeBloc>(context)
                                  .add(GetPodcasts());
                            },
                          )
                        ],
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
        ),
      ),
    );
  }
}

class sideMenu extends StatelessWidget {
  final state;
  const sideMenu({this.state});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF081624),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF040a11),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 227, 227, 227),
                      child: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 0, 140, 255),
                      ),
                    ),
                    //Image(
                    //   image: AssetImage(
                    //       'Assets/images/podcast.png'), // add the image asset here
                    //   height: 50, // set the height here
                    //   width: 50, // set the width here
                    //   fit: BoxFit.contain, // set the BoxFit property here
                    // )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                    child: Text(
                      state.currentUser.name,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  )
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),

          ListTile(
            leading: Icon(
              Icons.mic,
              color: Colors.white,
            ),
            title: Text(
              'My Podcasts',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // handle item 1 tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPodcastsPage()),
              );
            },
          ),
          Divider(
            thickness: 1.0,
            color: Color(0xFF040a11),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            title: Text(
              'Favorites',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePodcastsPage()),
              );
            },
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text(
              'Account Settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // handle item 2 tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccountSettingsScreen()),
              );
            },
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),

          Container(
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  print("logout button pressed");
                  // Log user out
                },
                child: Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          // add more items as needed
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

//possible place holder possibly a place to put the the funfact
class funFact extends StatefulWidget {
  final state;
  funFact({required this.state});
  @override
  State<funFact> createState() => _funFactState();
}

class _funFactState extends State<funFact> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibility,
        child: Container(
          color: Color.fromARGB(55, 160, 160, 160),
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      child: Icon(Icons.close))
                ],
              ),
              (widget.state is PodcastLoadedState)
                  ? Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.only(bottom: 50),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              (widget.state is PodcastsErrorState)
                                  ? ""
                                  : widget.state.funFact.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              (widget.state is PodcastsErrorState)
                                  ? "An error Occured"
                                  : widget.state.funFact.body,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 37, 153, 255),
                      ),
                    )
            ],
          ),
        ));
  }
}

//the search box component of the screen
class searchBox extends StatelessWidget {
  const searchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            hintText: '',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.blue,
              onPressed: () {
                // Perform search functionality here
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            filled: true,
            fillColor: Color(0xFF040a11),
          ),
          style: TextStyle(
            color: Colors.white, // Use any color of your choice
          ),
        ),
      ),
    );
  }
}
// Color(0xFF081624)

