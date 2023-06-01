part of 'edit_podcast_bloc.dart';

@immutable
abstract class EditPodcastState {}

class EditPodcastInitial extends EditPodcastState {}

class EditPodcastSuccess extends EditPodcastState {}

class EditPodcastError extends EditPodcastState {}
