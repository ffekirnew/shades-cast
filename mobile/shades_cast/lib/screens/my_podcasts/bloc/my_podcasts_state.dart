part of 'my_podcasts_bloc.dart';

@immutable
abstract class MyPodcastsState {}

class MyPodcastsInitial extends MyPodcastsState {}

class MyPodcastListerLoadingState extends MyPodcastsState {}

class MyPodcastLoadedState extends MyPodcastsState {
  final List<Podcast> podcasts;

  MyPodcastLoadedState({
    required this.podcasts,
  });
}

class MyPodcastErrorState extends MyPodcastsState {}
