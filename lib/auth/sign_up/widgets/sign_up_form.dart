import 'package:app_ui/app_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms/forms.dart';
import 'package:habit_away/auth/sign_up/sign_up.dart';
import 'package:habit_away/l10n/l10n.dart'; 

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> _obscurePassword;
  late ValueNotifier<bool> _obscureConfirmPassword;

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late TapGestureRecognizer _termsOfServiceRecognizer;
  late TapGestureRecognizer _policiesRecognizer;

  @override
  void initState() {
    super.initState();
    _obscurePassword = ValueNotifier(true);
    _obscureConfirmPassword = ValueNotifier(true);
  }

  @override
  void dispose() {
    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _termsOfServiceRecognizer.dispose();
    _policiesRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n; 
    final isLoading = context
        .select((SignUpCubit cubit) => cubit.state.submissionStatus.isLoading);

    return SignUpFormListener(
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: InputDecoration(
                  labelText: l10n.emailLabel,
                  hintText: l10n.emailHint,
                  prefixIcon: const Icon(Icons.mail),
                ),
                validator: (value) {
                  final email = Email.dirty(value ?? '');
                  return email.errorMessage;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _usernameController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: InputDecoration(
                  labelText: l10n.usernameLabel,
                  hintText: l10n.usernameHint,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  final username = Username.dirty(value ?? '');
                  return username.errorMessage;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<bool>(
                valueListenable: _obscurePassword,
                builder: (context, obscure, child) {
                  return TextFormField(
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    decoration: InputDecoration(
                      labelText: l10n.passwordLabel,
                      hintText: l10n.passwordHint,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                      ),
                    ),
                    obscureText: obscure,
                    validator: (value) {
                      final password = Password.dirty(value ?? '');
                      return password.errorMessage;
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureConfirmPassword,
                builder: (context, obscure, child) {
                  return TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: l10n.confirmPasswordLabel,
                      hintText: l10n.confirmPasswordHint,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          _obscureConfirmPassword.value =
                              !_obscureConfirmPassword.value;
                        },
                      ),
                    ),
                    obscureText: obscure,
                    validator: (value) {
                      final confirmPassword = ConfirmPassword.dirty(
                        password: _passwordController.text,
                        value: value ?? '',
                      );
                      switch (confirmPassword.error) {
                        case ConfirmPasswordValidationError.empty:
                          return l10n.confirmPasswordRequiredError;
                        case ConfirmPasswordValidationError.mismatch:
                          return l10n.passwordsDoNotMatchError;
                        case null:
                          return null;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              const AgreeInfo(),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                    ? null
                    : () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final email = _emailController.text;
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        context.read<SignUpCubit>().onSubmit(
                          username: username,
                          email: email,
                          password: password,
                        );
                      }
                      },
                  child: isLoading
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 2,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(l10n.pleaseWait),
                      ],
                    )
                  : Text(l10n.signUp, style: UITextStyle.ctaButton,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
