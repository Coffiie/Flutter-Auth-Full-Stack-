import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/repo/i_auth_repo.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_auth/domain/core/errors/api_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepo;

  LoginBloc({
    required this.authRepo,
  }) : super(LoginState.initial()) {
    on<_LoginPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(_LoginPressed event, Emitter emit) async {
    final username = event.username;
    final password = event.password;

    emit(LoginState.initial());

    if (username.isValid() && password.isValid()) {
      emit(
        LoginState.initial().copyWith(
          isSubmitting: true,
        ),
      );
      final failureOrSuccess = await authRepo.login(
        username: username,
        password: password,
      );
      failureOrSuccess.fold(
        (l) {
          emit(
            state.copyWith(
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
              isSubmitting: false,
            ),
          );
        },
        (r) => emit(
          state.copyWith(
            isAuthenticated: r.isAuthenticated,
            authFailureOrSuccessOption: none(),
            isSubmitting: false,
          ),
        ),
      );
    } else {
      emit(LoginState.initial().copyWith(showErrorMessages: true));
    }
  }
}
