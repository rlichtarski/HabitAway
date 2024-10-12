import 'package:authentication_client/authentication_client.dart';

class User extends AuthenticationUser {
  const User({
    required super.id,
    super.email,
    super.name,
    super.isNewUser,
  });

  /// Converts [AuthenticationUser] to [User].
  factory User.fromAuthenticationUser({
    required AuthenticationUser authenticationUser,
  }) =>
    User(
      email: authenticationUser.email,
      id: authenticationUser.id,
      name: authenticationUser.name,
      isNewUser: authenticationUser.isNewUser,
    );

  @override
  bool get isAnonymous => this == anonymous;

  static const User anonymous = User(id: '');
}
