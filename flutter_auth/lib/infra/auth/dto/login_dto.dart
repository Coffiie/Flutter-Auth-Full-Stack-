import 'package:flutter_auth/domain/auth/entities/login.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_dto.freezed.dart';
part 'login_dto.g.dart';

@freezed
class LoginDto with _$LoginDto {
  const LoginDto._();

  const factory LoginDto({
    required String token,
    required bool isAuthenticated,
  }) = _LoginDto;

  factory LoginDto.fromJson(Map<String, Object?> json) =>
      _$LoginDtoFromJson(json);

  Login toDomain() => Login(
        token: token,
        isAuthenticated: isAuthenticated,
      );
}
