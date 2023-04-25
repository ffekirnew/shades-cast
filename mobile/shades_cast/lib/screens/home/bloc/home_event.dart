part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SearchButtonClicked extends HomeEvent {}

class ItemClicked extends HomeEvent {}
