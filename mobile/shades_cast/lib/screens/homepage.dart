import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:http/http.dart' as http;
import 'settings.dart';
import 'myPodcasts.dart';

class homepage extends StatelessWidget {
  homepage({super.key});
  final PodcastApiClient podcastApiClient = PodcastApiClient(
    httpClient: http.Client(),
  );

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
          body: Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage(
                            'assets/logo.png'), // add the image asset here
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
                  Expanded(
                    child: podcastList(
                      podcastApiClient: podcastApiClient,
                    ),
                  )
                ],
              ),
            ),
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
                            'assets/logo.png'), // add the image asset here
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
  const podcastList({super.key, required this.podcastApiClient});
  final PodcastApiClient podcastApiClient;

  @override
  State<podcastList> createState() => _podcastListState();
}

class _podcastListState extends State<podcastList> {
  List<dynamic> podcasts = [];

  @override
  void initState() {
    super.initState();
    fetchPodcasts();
  }

  void fetchPodcasts() async {
    final result = await widget.podcastApiClient.getPodcasts();
    setState(() {
      podcasts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (podcasts.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListTileTheme(
        textColor: Colors.white,
        selectedColor: Colors.blue,
        tileColor: Color(0xFF040a11),
        selectedTileColor: Colors.grey.shade200,
        iconColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 25.0),
            itemCount: podcasts.length,
            itemBuilder: (BuildContext context, int index) {
              dynamic podcast = podcasts[index];
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.network(podcast["cover_image"]),
                  title: Text(podcast["title"]),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Author: ${podcast["author"]}'),
                      Text('Category: ${podcast["category"]}'),
                      Text('Episodes: ${podcast["episodes"].length}'),
                    ],
                  ),
                  onTap: () {
                    // Navigate to the podcast detail page
                  },
                ),
              );
            }),
      );
    }
  }
}

//possible place holder possibly a place to put the the funfact
class funFact extends StatelessWidget {
  const funFact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Placeholder(
        fallbackHeight: 220.0,
        child: Image(
          image: AssetImage("assets/logo.png"),
          fit: BoxFit.contain,
        ),
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
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
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
    );
  }
}
// Color(0xFF081624)

