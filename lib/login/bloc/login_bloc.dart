import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../model/model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginBloc({required this.authenticationRepository})
      : super(const LoginState()) {
    on<NameChangeEvent>(_onNameChanged);
    on<PasswordChangeEvent>(_passwordChangeEvent);
    on<UnFocusName>(_onUnFocusName);
    on<UnFocusPassword>(_onUnFocusPassword);
    on<OnSubmit>(_onSubmit);
  }

  FutureOr<void> _onNameChanged(
      NameChangeEvent event, Emitter<LoginState> emit) {
    final name = Name.dirty(event.userName);

    emit(state.copyWith(
        name: name.valid ? name : Name.pure(event.userName),
        formzStatus: Formz.validate([name, state.password])));
  }

  FutureOr<void> _passwordChangeEvent(
      PasswordChangeEvent event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        formzStatus: Formz.validate([state.name, password])));
  }

  FutureOr<void> _onUnFocusName(UnFocusName event, Emitter<LoginState> emit) {
    final name = Name.dirty(state.name.value);

    emit(state.copyWith(
        name: name, formzStatus: Formz.validate([name, state.password])));
  }

  FutureOr<void> _onUnFocusPassword(
      UnFocusPassword event, Emitter<LoginState> emit) {
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
        password: password,
        formzStatus: Formz.validate([state.name, password])));
  }

  FutureOr<void> _onSubmit(OnSubmit event, Emitter<LoginState> emit) async {
    final name = Name.dirty(state.name.value);
    final password = Password.dirty(state.name.value);

    emit(state.copyWith(
        name: name,
        password: password,
        formzStatus: Formz.validate([name, password])));

    if (state.formzStatus.isValid) {
      try {
        emit(state.copyWith(formzStatus: FormzStatus.submissionInProgress));
        await Future.delayed(const Duration(milliseconds: 300));
        await authenticationRepository.login(
            userName: state.name.value, password: state.password.value);
        emit(state.copyWith(formzStatus: FormzStatus.submissionSuccess));
      } catch (error) {
        emit(state.copyWith(formzStatus: FormzStatus.submissionFailure));
      }
    }
  }
}
