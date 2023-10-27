part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.registerPressed({
    required Username username,
    required Password password,
  }) = _RegisterPressed;
}
