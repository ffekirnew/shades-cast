part of 'add_funfact_bloc.dart';

@immutable
abstract class AddFunfactState {}

class AddFunfactInitial extends AddFunfactState {}

class AddFunfactErrorState extends AddFunfactState {}

class AddFunfactSuccessState extends AddFunfactState {}
