part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class AccountDetailSubmitted extends SettingsEvent {
  final dynamic accountDetails;
  AccountDetailSubmitted({this.accountDetails});
}
