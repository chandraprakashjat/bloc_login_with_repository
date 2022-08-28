part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> props() => [];
}

class LoadUser extends HomeEvent {
  const LoadUser();
  @override
  List<Object?> props() => [];
}

class LogoutUser extends HomeEvent {}
