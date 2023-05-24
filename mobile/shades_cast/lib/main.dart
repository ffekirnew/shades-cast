import 'package:flutter/material.dart';
import 'package:shades_cast/screens/my_podcasts/ui/myPodcasts.dart';
import 'screens/add_epsiode/ui/addEpisode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/login_and_signup/ui/login_and_signup.dart';
import './screens/login_and_signup/bloc/login_and_signup_bloc.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/ui/podcast_and_episode_player.dart';
import 'package:shades_cast/screens/podcast_and_episode_player/bloc/podcast_details_and_player_bloc.dart';
import 'package:shades_cast/screens/add_podcast/ui/addPodcast.dart';
import 'package:shades_cast/screens/settings/ui/settings.dart';
import 'package:shades_cast/screens/home/ui/homepage.dart';
import 'package:shades_cast/screens/home/bloc/home_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginAndSignupBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => PodcastDetailsAndPlayerBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeBloc(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: Color(0xFF09121C)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => homepage(),
          '/podcast': (context) => PodcastPage(podcastId: 1),
          '/addPodcast': (context) => addPodcasts(),
          '/addEpisode': (context) => AddEpisodeScreen(),
          '/myPodcasts': (context) => MyPodcastsPage(),
          '/settings': (context) => AccountSettingsScreen(),
        },
      ),
    ),
  );
}
