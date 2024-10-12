import 'package:equatable/equatable.dart';

class AuthenticationUser extends Equatable {
  const AuthenticationUser({
    required this.id,
    this.email,
    this.name,
    this.isNewUser = true,
  });

  final String? email;
  final String id;
  final String? name;
  final bool isNewUser;
  bool get isAnonymous => this == anonymous;
  static const anonymous = AuthenticationUser(id: '');

  @override
  List<Object?> get props => [email, id, name, isNewUser];
}
