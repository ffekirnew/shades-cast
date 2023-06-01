import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/constants.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';
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
import 'package:shades_cast/screens/my_podcasts/bloc/my_podcasts_bloc.dart';
import 'package:shades_cast/screens/add_podcast/bloc/add_podcast_bloc.dart';
import 'package:shades_cast/screens/settings/bloc/settings_bloc.dart';
import 'package:shades_cast/screens/my_podcasts/bloc/my_podcasts_bloc.dart';
import 'package:shades_cast/screens/add_epsiode/bloc/add_episode_bloc.dart';
import 'package:shades_cast/screens/funfact_list/bloc/funfact_bloc.dart';
import 'package:shades_cast/screens/add_funfact/bloc/add_funfact_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/authService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AuthService auth = AuthService();
  final token = await auth.getToken();
  bool isLoggedIn = (token != null);
  String initialRoute = isLoggedIn ? '/home' : '/';

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
        ),
        BlocProvider(
          create: (BuildContext context) => FavoritePodcastsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => SettingsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AddPodcastBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => MyPodcastsBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AddEpisodeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => FunfactBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => AddFunfactBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: KBodyBgPrimaryColor,
        ),
        initialRoute: initialRoute,
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => homepage(),
          '/podcast': (context) => PodcastPage(podcastId: 1),
          '/addPodcast': (context) => addPodcasts(),
          '/addEpisode': (context) => AddEpisodeScreen(
                podcastId: 1,
              ),
          '/myPodcasts': (context) => MyPodcastsPage(),
          '/settings': (context) => AccountSettingsScreen(),
        },
      ),
    ),
  );
}
