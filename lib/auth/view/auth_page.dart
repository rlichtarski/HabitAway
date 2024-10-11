import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthView();
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
        child: Text('AuthPage!'),
      ),
    );
  }
}
