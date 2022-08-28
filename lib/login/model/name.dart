import 'package:formz/formz.dart';

enum NameInputError { invalid }

class Name extends FormzInput<String, NameInputError> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);
  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.invalid : null;
  }
}
