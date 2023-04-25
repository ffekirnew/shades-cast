import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if (event is ItemClicked) {
        emit(ItemClickedState());
      } else if (event is SearchButtonClicked) {
        emit(SearchButtonClickedState());
      } else {
        print("Unknown State");
      }
    });
  }
}
