import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/addEpisode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/screens/addPodcast.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: Color(0xFF09121C)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => homepage(),
          '/addPodcast': (context) => addPodcasts(),
          '/addEpisode': (context) => AddEpisodeScreen(),
        },
      ),
    ),
  );
}
