part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SearchButtonClickedState extends HomeState {}

class ItemClickedState extends HomeState {}
