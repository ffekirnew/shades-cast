part of 'funfact_bloc.dart';

@immutable
abstract class FunfactEvent {}

class GetAllFunfacts extends FunfactEvent {}

class DeleteFunfact extends FunfactEvent {}
