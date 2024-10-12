import 'package:equatable/equatable.dart' show EquatableMixin;
import 'package:flutter/foundation.dart' show immutable;
import 'package:forms/src/formz_validation_mixin.dart';
import 'package:formz/formz.dart' show FormzInput;

@immutable
class Username extends FormzInput<String, UsernameValidationError>
    with EquatableMixin, FormzValidationMixin {
  const Username.pure([super.value = '']) : super.pure();

  const Username.dirty(super.value) : super.dirty();

  static final _nameRegex = RegExp(r'^[a-zA-Z0-9_\.\u0400-\u04FF]{3,16}$');

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    if (!_nameRegex.hasMatch(value)) return UsernameValidationError.invalid;
    return null;
  }

  @override
  Map<UsernameValidationError?, String?> get validationErrorMessage => {
    UsernameValidationError.empty: 'This field is required',
    UsernameValidationError.invalid:
        'Username must be between 3 and 16 characters. Also, it can only '
            'contain letters, numbers, periods, and underscores.',
  };

  @override
  List<Object?> get props => [isPure, value];
}

enum UsernameValidationError {
  empty,
  invalid,
}
