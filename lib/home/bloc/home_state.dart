part of 'home_bloc.dart';

enum HomeStatus { initial, success, failed }

class HomeState extends Equatable {
  const HomeState({
    this.user = User.empty,
    this.homeStatus = HomeStatus.initial,
  });
  final User user;
  final HomeStatus homeStatus;

  HomeState copyWith({User? user, HomeStatus? homeStatus}) {
    return HomeState(
      user: user ?? this.user,
      homeStatus: homeStatus ?? this.homeStatus,
    );
  }

  @override
  List<Object?> props() => [user, homeStatus];
}
