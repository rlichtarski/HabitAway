part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final SubmissionStatus submissionStatus;
  final Username name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  const SignUpState({
    this.submissionStatus = SubmissionStatus.initial,
    this.name = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  SignUpState copyWith({
    SubmissionStatus? submissionStatus,
    Username? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) => SignUpState(
    submissionStatus: submissionStatus ?? this.submissionStatus,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
  );

  @override
  List<Object> get props => [
    submissionStatus,
    name,
    email,
    password,
    confirmPassword,
  ];
}
