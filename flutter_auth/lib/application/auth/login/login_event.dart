part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginPressed({
    required Username username,
    required Password password,
  }) = _LoginPressed;
}
