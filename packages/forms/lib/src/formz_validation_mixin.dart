import 'package:formz/formz.dart';

mixin FormzValidationMixin<T, E> on FormzInput<T, E> {
  E? get validationError => isNotValid ? error : null;

  String? get errorMessage => validationErrorMessage[validationError];

  Map<E?, String?> get validationErrorMessage;
}
