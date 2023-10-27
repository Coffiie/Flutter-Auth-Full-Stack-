import 'package:dartz/dartz.dart';
import 'package:flutter_auth/domain/auth/validators/string_not_empty.dart';
import 'package:flutter_auth/domain/core/errors/value_failure.dart';
import 'package:flutter_auth/domain/core/value_objects/value_object.dart';

class Username extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Username(String input) => Username._(validateStringNotEmpty(input));

  const Username._(this.value);
}
