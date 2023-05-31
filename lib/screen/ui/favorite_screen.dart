import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorite_bloc.dart';
import '../../podcast.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final favoriteBloc = FavoriteBloc();
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
                color: Color.fromARGB(
                    55, 255, 255, 255)),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF081624),
              title: Text('Favorites'),
            ),
            body: BlocProvider(
                create: (context) => favoriteBloc,
                child: BlocBuilder(builder: (context, state) {
                  if (state is FavoriteInitial) {
                    return buildInitialUI(context); 
                  } else if (state is Loading) {
                    return buildLoadingUI(); 
                  } else if (state is Loaded) {
                    return buildLoadedUI(
                        state.podcasts); 
                  } else if (state is Navigator) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 

                            // PlayEpisodeScreen(podcast: podcast),
                      ),
                    );
                  } else if (state is Empty) {
                    return buildEmptyUI(context); 
                  } else {
                    return Container(); 
                  }
                }))));
  }

  Widget buildInitialUI( BuildContext context) {
    BlocProvider.of<FavoriteBloc>(context).add(InitialEvent());
    return CircularProgressIndicator();
  }
  Widget buildLoadingUI() => CircularProgressIndicator();
  Widget buildLoadedUI(List<Podcast> podcasts) {
    return ListView.builder(
    itemCount: podcasts.length,
    itemBuilder: (context, index) {
      final podcast = podcasts[index];
      final defalutUrl = "https://tse1.mm.bing.net/th?id=OIP.3L6hJEZnzwXBcNTrjedn_gHaEo&pid=Api&P=0&h=180";
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(podcast.imageUrl ?? defalutUrl),
        ),
        title: Text(podcast.title),
        onTap: () {
          BlocProvider.of<FavoriteBloc>(context).add(
            TapToListen(podcast)
          );
        },
       trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            BlocProvider.of<FavoriteBloc>(context).add(
              SwipeOutPodcast(index),
            );
          },
        ),
      );
    },
  );
  }
  Widget buildEmptyUI(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No favorite podcasts found',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/podcasts');
          },
          child: Text('Listen to Podcasts'),
        ),
      ],
    ),
  );
}


  @override
  void dispose() {
    super.dispose();
    favoriteBloc.dispose();
  }
}
