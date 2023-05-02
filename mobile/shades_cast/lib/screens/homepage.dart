import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:http/http.dart' as http;

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
          body: Padding(
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
  late final PodcastApiClient podcastApiClient;

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
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(podcasts[index]["cover_image"]),
          ),
          title: Text(podcasts[index]["title"]),
          subtitle: Text(podcasts[index]["slug"]),
          onTap: () {
            // Navigate to the podcast details screen
          },
        );
      },
    );
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