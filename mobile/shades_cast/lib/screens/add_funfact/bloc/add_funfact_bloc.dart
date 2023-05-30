import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_funfact_event.dart';
part 'add_funfact_state.dart';

class AddFunfactBloc extends Bloc<AddFunfactEvent, AddFunfactState> {
  AddFunfactBloc() : super(AddFunfactInitial()) {
    on<AddFunfactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
