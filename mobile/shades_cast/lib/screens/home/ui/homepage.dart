import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:http/http.dart' as http;
import '../../settings.dart';
import '../../myPodcasts.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

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
          drawer: sideMenu(),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
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
                    funFact(),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Listen Podcasts",
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
                        : ElevatedButton(
                            onPressed: () => (BlocProvider.of<HomeBloc>(context)
                                .add(GetPodcasts())),
                            child: Text("Get Podcasts"))
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
  const sideMenu({
    super.key,
  });

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
              child: Row(children: [
                Column(children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                      child: Text(
                        'Hello,',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(3.0, 20.0, 0, 0),
                      child: Text(
                        "Friend",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    )
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage(
                            'Assets/images/podcast.png'), // add the image asset here
                        height: 50, // set the height here
                        width: 50, // set the width here
                        fit: BoxFit.contain, // set the BoxFit property here
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Text(
                        "followers",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "following",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 110.0,
                      ),
                      Text(
                        "100",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "19",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ]),
                Divider(
                  thickness: 2.0,
                  color: Colors.white,
                )
              ]),
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
              color: Color(0xFF999EA3),
            ),
            title: Text(
              'My Podcasts',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF999EA3)),
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
              color: Color(0xFF999EA3),
            ),
            title: Text(
              'Favourites',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF999EA3)),
            ),
            onTap: () {
              // handle item 2 tap
            },
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Color(0xFF999EA3),
            ),
            title: Text(
              'Account Settings',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF999EA3)),
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
          SizedBox(
            height: 325.0,
          ),
          FloatingActionButton(
              onPressed: () {
                print("logout button pressed");
                // Log user out
              },
              backgroundColor: Colors.blue[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
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
          // Naviga
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          color: Color.fromARGB(255, 0, 0, 0),
          child: ListTile(
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
            subtitle: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                //  currentPodcast.description ?? "",
                "some description to check how the subtitle exactly looks and if it can be used",
                style: TextStyle(
                    color: Color.fromARGB(145, 255, 255, 255),
                    fontWeight: FontWeight.w200),
              ),
            ),
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
  @override
  State<funFact> createState() => _funFactState();
}

class _funFactState extends State<funFact> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Placeholder(
              fallbackHeight: 200.0,
              child: Image(
                image: AssetImage('Assets/images/podcast.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
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

