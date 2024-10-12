import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:flutter/foundation.dart' show immutable;
import 'package:forms/src/formz_validation_mixin.dart';
import 'package:formz/formz.dart';

@immutable
class Email extends FormzInput<String, EmailValidationError>
    with EquatableMixin, FormzValidationMixin {

  const Email.pure([super.value = '']) : super.pure();
  const Email.dirty(super.value) : super.dirty();

  static final _emailRegex = RegExp(
    r'^(([\w-]+\.)+[\w-]+|([a-zA-Z]|[\w-]{2,}))@((([0-1]?'
    r'[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.'
    r'([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
    r')|([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!_emailRegex.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }

  @override
  Map<EmailValidationError?, String?> get validationErrorMessage => {
    EmailValidationError.empty: 'This field is required',
    EmailValidationError.invalid: 'Email is not correct',
  };

  @override
  List<Object> get props => [isPure, value];
}

enum EmailValidationError {
  empty,
  invalid,
}
