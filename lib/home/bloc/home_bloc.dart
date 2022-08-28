import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  HomeBloc(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository})
      : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const HomeState()) {
    on<LoadUser>(_onLoadUserDetail);
    on<LogoutUser>(_onLogoutUser);
  }

  FutureOr<void> _onLoadUserDetail(
      LoadUser event, Emitter<HomeState> emit) async {
    emit(state.copyWith(homeStatus: HomeStatus.initial));

    String userId = _authenticationRepository.getUserId();
    final userDetail = await _getUserDetail();

    emit(state.copyWith(
        user: userDetail ?? User.empty,
        homeStatus:
            userDetail == null ? HomeStatus.failed : HomeStatus.success));
  }

  FutureOr<void> _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) {
    _authenticationRepository.logout();
  }

  _getUserDetail() async {
    await Future.delayed(const Duration(seconds: 5));
    User? user = await _userRepository.getUser();
    return user;
  }
}
