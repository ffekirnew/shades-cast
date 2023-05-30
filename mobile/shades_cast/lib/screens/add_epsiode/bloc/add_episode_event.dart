part of 'add_episode_bloc.dart';

@immutable
abstract class AddEpisodeEvent {}

class EpsiodeSubmitted extends AddEpisodeEvent {
  dynamic createdEpsiode;
  EpsiodeSubmitted({required this.createdEpsiode});
}
