part of 'add_funfact_bloc.dart';

@immutable
abstract class AddFunfactEvent {}

class FunfactSubmitted extends AddFunfactEvent {
  final fact;
  FunfactSubmitted({required this.fact});
}
