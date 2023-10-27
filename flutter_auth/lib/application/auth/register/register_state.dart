part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const RegisterState._();

  const factory RegisterState({
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isRegistered,
    required Option<Either<ApiFailure, dynamic>> authFailureOrSuccessOption,
  }) = _RegisterState;

  factory RegisterState.initial() => RegisterState(
        showErrorMessages: false,
        isSubmitting: false,
        isRegistered: false,
        authFailureOrSuccessOption: none(),
      );
}
