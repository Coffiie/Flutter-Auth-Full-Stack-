import 'package:freezed_annotation/freezed_annotation.dart';

part 'register.freezed.dart';

@freezed
class Register with _$Register {
  const Register._();

  const factory Register({
    required String token,
    required String message,
  }) = _Register;

  factory Register.empty() => const Register(token: '', message: '');
}
