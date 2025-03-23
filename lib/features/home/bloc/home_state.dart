part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class BatteryLoaded extends HomeState {
  final String batteryLevel;

  BatteryLoaded(this.batteryLevel);
}
