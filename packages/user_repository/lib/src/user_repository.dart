import 'dart:async';

import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/user.dart';

abstract class UserFailure with EquatableMixin implements Exception {
  const UserFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class UserRepository {
  const UserRepository({
    required AuthenticationClient authenticationClient,
  }) : _authenticationClient = authenticationClient;

  final AuthenticationClient _authenticationClient;

  Stream<User> get user => _authenticationClient.user
      .map((user) => User.fromAuthenticationUser(authenticationUser: user));

  Future<void> logInWithGoogle() async {
    try {
      await _authenticationClient.logInWithGoogle();
    } on LogInWithGoogleFailure {
      rethrow;
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }

  Future<void> logInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.logInWithPassword(
        email: email,
        password: password,
      );
    } on LogInWithPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithPasswordFailure(error), stackTrace);
    }
  }

  Future<void> signUpWithPassword({
    required String password,
    required String email,
    required String username,
    String? photo,
  }) async {
    try {
      await _authenticationClient.signUpWithPassword(
        email: email,
        password: password,
        username: username,
      );
    } on SignUpWithPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignUpWithPasswordFailure(error), stackTrace);
    }
  }

  /// will emit [User.anonymous] from the [user] Stream after calling
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  Future<void> updateProfile({
    String? username,
  }) async {
    try {
      await _authenticationClient.updateProfile(username: username);
    } on UpdateProfileFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateProfileFailure(error), stackTrace);
    }
  }

  Future<void> updateEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.updateEmail(email: email, password: password);
    } on UpdateEmailFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateEmailFailure(error), stackTrace);
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _authenticationClient.deleteAccount();
    } on DeleteAccountFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeleteAccountFailure(error), stackTrace);
    }
  }
}
