import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_away/auth/cubit/auth_cubit.dart';
import 'package:habit_away/auth/login/login.dart';
import 'package:habit_away/auth/sign_up/sign_up.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const AuthView(),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final showLogin = context.select((AuthCubit authCubit) => authCubit.state);

    return PageTransitionSwitcher(
      reverse: showLogin,
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      child: showLogin ? const LoginPage() : const SignUpPage(),
    );
  }
}
