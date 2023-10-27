import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/repo/i_auth_repo.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_auth/domain/core/errors/api_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IAuthRepository authRepo;

  RegisterBloc({
    required this.authRepo,
  }) : super(RegisterState.initial()) {
    on<_RegisterPressed>(_onRegisterPressed);
  }

  Future<void> _onRegisterPressed(_RegisterPressed event, Emitter emit) async {
    final username = event.username;
    final password = event.password;

    emit(RegisterState.initial());

    if (username.isValid() && password.isValid()) {
      emit(
        RegisterState.initial().copyWith(
          isSubmitting: true,
        ),
      );
      final failureOrSuccess = await authRepo.register(
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
            authFailureOrSuccessOption: none(),
            isSubmitting: false,
            isRegistered: true,
          ),
        ),
      );
    } else {
      emit(RegisterState.initial().copyWith(showErrorMessages: true));
    }
  }
}
