import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shades_cast/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<AccountDetailSubmitted>((event, emit) async {
      try {
        print('in bloc trying to update user');
        UserRepo userRepo = UserRepo();
        dynamic userCreated = event.accountDetails;
        await userRepo.updateUser(userCreated);
        emit(SettingsSuccess());
      } catch (e) {
        print(e);
        emit(SettingsError());
      }
    });
  }
}
