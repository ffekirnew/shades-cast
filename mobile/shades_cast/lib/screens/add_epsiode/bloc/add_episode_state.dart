part of 'add_episode_bloc.dart';

@immutable
abstract class AddEpisodeState {}

class AddEpisodeInitial extends AddEpisodeState {}

class AddEpisodeSuccess extends AddEpisodeState {}

class AddEpisodeError extends AddEpisodeState {}
