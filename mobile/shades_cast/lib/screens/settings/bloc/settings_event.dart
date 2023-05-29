part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class DetailSubmitted extends SettingsEvent {
  final dynamic accountDetails;
  DetailSubmitted({this.accountDetails});
}
