part of 'funfact_bloc.dart';

@immutable
abstract class FunfactState {
  final List<Funfact> funfacts = [];
}

class FunfactInitial extends FunfactState {}

class FunfactLoadedState extends FunfactState {
  final List<Funfact> funfacts;
  FunfactLoadedState({required this.funfacts});
}

class FunfactErrorState extends FunfactState {
  final List<Funfact> funfacts = [];
}
