import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'funfact_event.dart';
part 'funfact_state.dart';

class FunfactBloc extends Bloc<FunfactEvent, FunfactState> {
  FunfactBloc() : super(FunfactInitial()) {
    on<FunfactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
