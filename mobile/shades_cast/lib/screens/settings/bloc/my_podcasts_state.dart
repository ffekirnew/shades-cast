part of 'my_podcasts_bloc.dart';

@immutable
abstract class MyPodcastsState {}

class MyPodcastsInitial extends MyPodcastsState {}

class MyPodcastSuccess extends MyPodcastsState {}

class MyPodcastError extends MyPodcastsState {}
