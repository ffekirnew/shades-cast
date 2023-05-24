import 'package:flutter/material.dart';
import 'package:shades_cast/screens/add_podcast/ui/addPodcast.dart';
import '../../add_podcast/ui/addPodcast.dart';

class MyPodcastsPage extends StatefulWidget {
  MyPodcastsPage();

  @override
  _MyPodcastsPageState createState() => _MyPodcastsPageState();
}

class _MyPodcastsPageState extends State<MyPodcastsPage> {
  late List<dynamic> _podcasts = [
    {
      "id": 1,
      "creator": 1,
      "title": "The Daily Show",
      "slug": "the-daily-show",
      "description":
          "The Daily Show is a popular podcast that offers a humorous take on the day's top news stories and current events. Hosted by a team of witty and knowledgeable commentators, the show covers everything from politics and world events to pop culture and entertainment.\r\n\r\nEach episode features a mix of insightful analysis, witty commentary, and hilarious satire, delivered with a fresh and irreverent perspective that keeps listeners coming back for more. The show's hosts are skilled at unpacking complex issues and making them accessible to a wide audience, without sacrificing accuracy or depth of coverage.\r\n\r\nWhether you're a news junkie looking for a new take on the day's headlines, or just looking for a laugh at the end of a long day, The Daily Show is the perfect podcast for you. With new episodes dropping daily, you'll never be out of the loop when it comes to the latest news and trends, all delivered with the signature wit and humor that has made the show a fan favorite for years.",
      "cover_image":
          "https://fikernewapi.pythonanywhere.com/media/the-daily-show/cover-images/8676ec02-605c-4d61-9143-1be25171b3c3.webp",
      "category": "satire",
      "publish": "2023-04-11T21:06:59Z",
      "status": "public",
      "episodes": [
        {
          "id": 3,
          "title": "The First One",
          "slug": "the-first-one",
          "audio_file":
              "https://fikernewapi.pythonanywhere.com/media/the-daily-show/2023/04/13/545d7084-ad84-4878-b849-fb6e5217a2e3.mp3",
          "audio_duration": 340,
          "audio_size": 5446981,
          "podcast": 1,
          "publish": "2023-04-13T09:50:34Z",
          "description":
              "\"The First One\" is a podcast episode that takes a nostalgic look back at some of the most iconic firsts in history. From the first flight by the Wright brothers, to the first person to step on the moon, and even the first computer ever created, this episode explores the groundbreaking moments that shaped our world.\r\n\r\nHosted by a knowledgeable and engaging host, each segment of the podcast focuses on a different historical first and delves into the fascinating stories behind them. Listeners will learn about the challenges, setbacks, and triumphs that led to these pivotal moments, and gain a newfound appreciation for the ingenuity and perseverance of those who made them possible.\r\n\r\nBut \"The First One\" isn't just about looking back in time. The podcast also explores current events and upcoming innovations that could be the next groundbreaking firsts in their respective fields. From space exploration to artificial intelligence, listeners will be inspired and informed about the latest breakthroughs that could change the world as we know it.\r\n\r\nWhether you're a history buff, a science enthusiast, or simply curious about the world around you, \"The First One\" is a podcast that will inform and entertain in equal measure. Tune in to hear about the firsts that made history, and the firsts that are yet to come.",
          "status": "published"
        },
        {
          "id": 4,
          "title": "Y Combinator",
          "slug": "y-combinator",
          "audio_file": null,
          "audio_duration": null,
          "audio_size": null,
          "podcast": 1,
          "publish": "2023-04-13T10:20:50Z",
          "description":
              "But \"The First One\" isn't just about looking back in time. The podcast also explores current events and upcoming innovations that could be the next groundbreaking firsts in their respective fields. From space exploration to artificial intelligence, listeners will be inspired and informed about the latest breakthroughs that could change the world as we know it.",
          "status": "draft"
        }
      ]
    },
    {
      "id": 2,
      "creator": 1,
      "title": "The New Show",
      "slug": "the-new-show",
      "description": "This is a new show.",
      "cover_image":
          "https://fikernewapi.pythonanywhere.com/media/the-new-show/cover-images/16614c58-c166-4d3d-acae-21a884c967d1.jpg",
      "category": "Serious",
      "publish": "2023-04-21T13:14:03.869918Z",
      "status": "public",
      "episodes": []
    }
  ];

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
          bodyMedium: TextStyle(color: Colors.white), // set the text color here
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF081624),
          title: Text('My Podcasts'),
        ),
        body: _podcasts.isEmpty
            ? Center(
                child: Text('No podcasts found.'),
              )
            : ListView.builder(
                itemCount: _podcasts.length,
                itemBuilder: (context, index) {
                  final podcast = _podcasts[index];
                  return demo(
                    title: podcast["title"],
                    category: podcast["category"],
                    episodes: podcast["episodes"].length,
                    coverImage: podcast["cover_image"],
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
