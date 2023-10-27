part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isAuthenticated,
    required Option<Either<ApiFailure, dynamic>> authFailureOrSuccessOption,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        showErrorMessages: false,
        isSubmitting: false,
        isAuthenticated: false,
        authFailureOrSuccessOption: none(),
      );
}
