import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_away/auth/sign_up/sign_up.dart';
import 'package:user_repository/user_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpCubit(userRepository: context.read<UserRepository>()),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(
              height: AppSpacing.xlg,
            ),
            Text(
              'Join Habit Away today!', 
              style: UITextStyle.headline1,
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            Text(
              'Start your journey with breaking bad habits!',
              style: UITextStyle.bodyText1,
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}
