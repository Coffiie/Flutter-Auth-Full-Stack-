import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/core/errors/value_failure.dart';

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  return input.isNotEmpty
      ? right(input)
      : left(ValueFailure.empty(failedValue: input));
}

Either<ValueFailure<String>, String> confirmPasswords(
  String password,
  String confirmPassword,
) {
  return password == confirmPassword
      ? right(password)
      : left(ValueFailure.notEqual(failedValue: password));
}
