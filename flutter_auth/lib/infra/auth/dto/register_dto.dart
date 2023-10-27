import 'package:flutter_auth/domain/auth/entities/register.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_dto.freezed.dart';
part 'register_dto.g.dart';

@freezed
class RegisterDto with _$RegisterDto {
  const RegisterDto._();

  const factory RegisterDto({
    required String token,
    required String message,
  }) = _RegisterDto;

  factory RegisterDto.fromJson(Map<String, Object?> json) =>
      _$RegisterDtoFromJson(json);

  Register toDomain() => Register(
        token: token,
        message: message,
      );
}
