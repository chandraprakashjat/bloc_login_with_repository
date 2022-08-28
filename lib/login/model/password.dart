import 'package:formz/formz.dart';

enum PasswordInputError { invalid }

class Password extends FormzInput<String, PasswordInputError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);
  @override
  PasswordInputError? validator(String value) {
    return value.isEmpty ? PasswordInputError.invalid : null;
  }
}
