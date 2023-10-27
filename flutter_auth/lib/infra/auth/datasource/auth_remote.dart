import 'package:dio/dio.dart';
import 'package:flutter_auth/config.dart';
import 'package:flutter_auth/domain/auth/entities/login.dart';
import 'package:flutter_auth/domain/auth/entities/register.dart';
import 'package:flutter_auth/infra/auth/dto/login_dto.dart';
import 'package:flutter_auth/infra/auth/dto/register_dto.dart';

class AuthRemoteDataSource {
  final _dio = Dio();

  Future<Login> login(String username, String password) async {
    final Response response = await _dio.post(
      '${Config.url}/login',
      data: {
        'username': username,
        'password': password,
      },
    );
    _checkException(response);
    return LoginDto.fromJson(response.data).toDomain();
  }

  Future<Register> register(String username, String password) async {
    final Response response = await _dio.post(
      '${Config.url}/signup',
      data: {
        'username': username,
        'password': password,
      },
    );
    _checkException(response);
    return RegisterDto.fromJson(response.data).toDomain();
  }

  void _checkException(Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'BAD REQUEST',
      );
    }
  }
}
