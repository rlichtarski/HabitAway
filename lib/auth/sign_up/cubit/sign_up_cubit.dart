import 'dart:async';

import 'package:bloc/bloc.dart' show Cubit;
import 'package:equatable/equatable.dart';
import 'package:forms/forms.dart';
import 'package:habit_away/auth/shared/submission_status.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const SignUpState());

  final UserRepository _userRepository;

  void reset() {
    const name = Username.pure();
    const password = Password.pure();
    const confirmPassword = ConfirmPassword.pure();
    final newState = state.copyWith(
      submissionStatus: SubmissionStatus.initial,
      name: name,
      password: password,
      confirmPassword: confirmPassword,
    );
    emit(newState);
  }

  Future<void> onSubmit({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(submissionStatus: SubmissionStatus.loading));

    try {
      await _userRepository.signUpWithPassword(
        username: username,
        email: email,
        password: password,
      );

      emit(state.copyWith(submissionStatus: SubmissionStatus.success));
    } catch (error, stackTrace) {
      addError(error, stackTrace);

      final submissionStatus = switch (error) {
        final TimeoutException _ => SubmissionStatus.timeoutError,
        _ => SubmissionStatus.error,
      };
      emit(state.copyWith(submissionStatus: submissionStatus));
    }
  }
}
