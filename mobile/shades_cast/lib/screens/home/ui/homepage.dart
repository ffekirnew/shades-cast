import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';
import '../../../Infrustructure_layer/api_clients/constants.dart';
import '../../settings/ui/settings.dart';
import '../../my_podcasts/ui/myPodcasts.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shades_cast/screens/favorite_podcasts/ui/favorite_podcasts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shades_cast/screens/funfact_list/ui/funfact_list.dart';
import 'package:shades_cast/screens/funfact_list/bloc/funfact_bloc.dart';
import 'package:shades_cast/domain_layer/user.dart';

class homepage extends StatelessWidget {
  homepage({super.key});
  final PodcastApiClient podcastApiClient = PodcastApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return sideMenu(
            state: state,
          );
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
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
                        key: Key('home_page_menu_button'),
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
                  funFact(
                    state: state,
                    context: context,
                  ),
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
                            print('refreshed');
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                funFact(
                  state: state,
                  context: context,
                ),
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
                          BlocProvider.of<HomeBloc>(context).add(GetPodcasts());
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
                      radius: 50.0,
                      child: Icon(Icons.person),
                      // backgroundImage: state.currentUser.profile != null
                      //     ? NetworkImage(
                      //         '$api/' + state.currentUser.profile['photo'])
                      //     : // Display the selected image if available
                      //     AssetImage('assets/logo.png') as ImageProvider<
                      //         Object>, // Display a default image
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
                      "@ " + state.currentUser.name,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 55, 172, 255)),
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
            key: Key('my_podcasts_button'),
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
                MaterialPageRoute(
                    builder: (context) => MyPodcastsPage(
                          refresh: true,
                        )),
              );
            },
          ),
          Divider(
            thickness: 1.0,
            color: Color(0xFF040a11),
          ),
          ListTile(
            key: Key('favorite_podcasts_button'),
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
                MaterialPageRoute(
                    builder: (context) => FavoritePodcastsPage(
                          refresh: true,
                        )),
              );
            },
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),
          ListTile(
            key: Key('account_settings_button'),
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
              print(state.currentUser.toMap());
              // handle item 2 tap
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AccountSettingsScreen(
                          refresh: true,
                          user: User(
                              id: state.currentUser.id,
                              name: state.currentUser.name,
                              email: state.currentUser.email,
                              profile: state.currentUser.profile,
                              password: ''),
                        )),
              );
            },
          ),
          Divider(
            thickness: 2.0,
            color: Color(0xFF040a11),
          ),
          (state.currentUser.is_admin != null && state.currentUser.is_admin)
              ? ListTile(
                  key: Key('admin_funfacts_button'),
                  leading: Icon(
                    Icons.note,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Funfacts',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // handle item 2 tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FunFactListScreen(
                                refresh: true,
                              )),
                    );
                  },
                )
              : Container(),

          (state.currentUser.name == 'admin')
              ? Divider(
                  thickness: 2.0,
                  color: Color(0xFF040a11),
                )
              : Container(),

          Container(
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
                key: Key('logout_button'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('token');

                  Navigator.pushReplacementNamed(context, '/');
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
          BlocProvider.of<PodcastDetailsAndPlayerBloc>(context).add(
              PodcastDetailPageOpened(
                  podcastId: currentPodcast.id, isFromMyPodcasts: false));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15)),
            color: Color(0xFF040a11),
          ),
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              ListTile(
                // tileColor: Colors.redAccent,
                leading: Image(
                  image: NetworkImage(currentPodcast.imageUrl ??
                      "https://fikernewapi.pythonanywhere.com/media/the-daily-show/cover-images/d0260764-4aae-4180-8c49-0b6110c877f9.jpg"), //dummy image for place holder if no image
                ),
                title: Text(
                  currentPodcast.title,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Container(
                  // margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                  child: Text(
                    currentPodcast.description ??
                        "some description to check how the subtitle exactly looks and if it can be used",
                    style: TextStyle(
                        color: Color.fromARGB(205, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
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
  final context;
  funFact({required this.state, required this.context});
  @override
  State<funFact> createState() => _funFactState();
}

class _funFactState extends State<funFact> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.state.funfactVisibility,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          // padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(FunfactWindowClosed(context: widget.context));
                      },
                      child: Icon(Icons.close))
                ],
              ),
              ((widget.state is PodcastLoadedState) |
                      (widget.state is PodcastsErrorState))
                  ? Container(
                      color: Color.fromARGB(99, 0, 170, 255),
                      // margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.only(bottom: 20, top: 20),
                              child: Text(
                                (widget.state is PodcastsErrorState)
                                    ? ""
                                    : widget.state.funFact.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 10),
                              child: Text(
                                (widget.state is PodcastsErrorState)
                                    ? "An error Occured"
                                    : widget.state.funFact.body,
                                style: (widget.state is PodcastsErrorState)
                                    ? TextStyle(color: Colors.red, fontSize: 16)
                                    : TextStyle(
                                        color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      color: Color.fromARGB(129, 67, 160, 207),
                      padding: EdgeInsets.only(bottom: 20, top: 20),
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
  TextEditingController searchInputController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  searchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Container(
        height: 50,
        child: TextField(
          key: Key('home_page_search_text_field'),
          scrollPadding: EdgeInsets.all(0),
          onEditingComplete: () {
            searchFocusNode.unfocus();
            BlocProvider.of<HomeBloc>(context)
                .add(PodcastSearched(searchTerm: searchInputController.text));
          },
          controller: searchInputController,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            hintText: '',
            suffixIcon: IconButton(
              key: Key('home_page_search_button'),
              icon: Icon(Icons.search),
              color: Colors.blue,
              onPressed: () {
                // Perform search functionality here
                searchFocusNode.unfocus();
                BlocProvider.of<HomeBloc>(context).add(
                    PodcastSearched(searchTerm: searchInputController.text));
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
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

