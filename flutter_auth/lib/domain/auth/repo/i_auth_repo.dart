import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/entities/login.dart';
import 'package:flutter_auth/domain/auth/entities/register.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_auth/domain/core/errors/api_failure.dart';

abstract class IAuthRepository {
  Future<Either<ApiFailure, Login>> login({
    required Username username,
    required Password password,
  });

  Future<Either<ApiFailure, Register>> register({
    required Username username,
    required Password password,
  });
}
