part of 'edit_funfact_bloc.dart';

@immutable
abstract class EditFunfactEvent {}

class EditFunfactSubmitted extends EditFunfactEvent {
  dynamic modifiedFunfact;
  int FunfactId;
  EditFunfactSubmitted(
      {required this.modifiedFunfact, required this.FunfactId});
}
