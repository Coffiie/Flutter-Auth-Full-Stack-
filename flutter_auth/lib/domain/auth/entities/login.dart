import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.freezed.dart';

@freezed
class Login with _$Login {
  const Login._();

  const factory Login({
    required String token,
    required bool isAuthenticated,
  }) = _Login;

  factory Login.empty() => const Login(token: '', isAuthenticated: false);
}
