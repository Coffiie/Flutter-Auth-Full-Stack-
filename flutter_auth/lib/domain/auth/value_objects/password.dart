import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/validators/string_not_empty.dart';
import 'package:flutter_auth/domain/core/errors/value_failure.dart';
import 'package:flutter_auth/domain/core/value_objects/value_object.dart';

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password.login(String input) {
    return Password._(validateStringNotEmpty(input));
  }

  factory Password.register(String password, String confirmPassword) {
    return Password._(
      validateStringNotEmpty(password)
          .flatMap((a) => validateStringNotEmpty(confirmPassword))
          .flatMap((a) => confirmPasswords(password, confirmPassword)),
    );
  }

  const Password._(this.value);
}
