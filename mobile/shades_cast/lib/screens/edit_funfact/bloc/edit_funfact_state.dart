part of 'edit_funfact_bloc.dart';

@immutable
abstract class EditFunfactState {}

class EditFunfactInitial extends EditFunfactState {}

class EditFunfactSuccess extends EditFunfactState {}

class EditFunfactError extends EditFunfactState {}
