part of 'add_podcast_bloc.dart';

@immutable
abstract class AddPodcastState {}

class AddPodcastInitial extends AddPodcastState {}

class AddPodcastSuccess extends AddPodcastState {}

class AddPodcastError extends AddPodcastState {}
