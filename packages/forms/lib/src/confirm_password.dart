import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPassword
    extends FormzInput<String, ConfirmPasswordValidationError> {
      
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return ConfirmPasswordValidationError.empty;
    } else if (value != password) {
      return ConfirmPasswordValidationError.mismatch;
    }
    return null;
  }
}
