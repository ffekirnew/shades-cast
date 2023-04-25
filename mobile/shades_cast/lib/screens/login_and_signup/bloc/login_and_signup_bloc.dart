import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_and_signup_event.dart';
part 'login_and_signup_state.dart';

class LoginAndSignupBloc
    extends Bloc<LoginAndSignupEvent, LoginAndSignupState> {
  LoginAndSignupBloc() : super(LoginAndSignupInitial()) {
    on<LoginAndSignupEvent>((event, emit) {
      // TODO: implement event handler
      if (event is ToLoginButtonClicked) {
        emit(LoginState());
      } else {
        emit(SignupState());
      }
    });
  }
}
