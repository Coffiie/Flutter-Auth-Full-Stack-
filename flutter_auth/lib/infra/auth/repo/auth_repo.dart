import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/entities/login.dart';
import 'package:flutter_auth/domain/auth/entities/register.dart';
import 'package:flutter_auth/domain/auth/repo/i_auth_repo.dart';
import 'package:flutter_auth/domain/auth/value_objects/password.dart';
import 'package:flutter_auth/domain/auth/value_objects/username.dart';
import 'package:flutter_auth/domain/core/errors/api_failure.dart';
import 'package:flutter_auth/infra/auth/datasource/auth_remote.dart';

class AuthRepository extends IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<ApiFailure, Login>> login({
    required Username username,
    required Password password,
  }) async {
    try {
      final login = await authRemoteDataSource.login(
        username.getOrCrash(),
        password.getOrCrash(),
      );
      if (login.isAuthenticated) {
        return Right(login);
      } else {
        return const Left(ApiFailure.serverError('Invalid Credentials'));
      }
    } catch (e) {
      return const Left(ApiFailure.serverError('Invalid Credentials'));
    }
  }

  @override
  Future<Either<ApiFailure, Register>> register({
    required Username username,
    required Password password,
  }) async {
    try {
      final register = await authRemoteDataSource.register(
        username.getOrCrash(),
        password.getOrCrash(),
      );
      if (register.token.isNotEmpty) {
        return Right(register);
      } else {
        return const Left(ApiFailure.serverError('Username already exists!'));
      }
    } catch (e) {
      return const Left(ApiFailure.serverError('Username already exists!'));
    }
  }
}
