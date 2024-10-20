import 'package:app_ui/app_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_away/app/language/language_provider.dart';
import 'package:habit_away/app/legal/widgets/agree_info_dialog.dart';
import 'package:habit_away/app/legal/widgets/agree_info_modal.dart';
import 'package:habit_away/l10n/l10n.dart'; 

class AgreeInfo extends StatelessWidget {
  const AgreeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: l10n.agreeToTermsPart1,
          children: [
            TextSpan(
              text: l10n.termsOfService,
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.isIOS
                  ? showModalBottomSheet<void>(
                    backgroundColor: AppColors.transparent,
                    isScrollControlled: true,
                    elevation: 0,
                    context: context, 
                    builder: (context) => AgreeInfoModal(
                      mdFileName: context
                        .read<LanguageProvider>()
                        .currentLocale
                        .languageCode == 'en' 
                          ? 'terms_and_conditions.md' 
                          : 'terms_and_conditions_pl.md',
                      typeOfDialogText: l10n.termsAndConditionsTitle,
                    )
                  )
                  : showDialog<void>(
                    context: context, 
                    builder: (context) => AgreeInfoDialog(
                      mdFileName: context
                        .read<LanguageProvider>()
                        .currentLocale
                        .languageCode == 'en' 
                          ? 'terms_and_conditions.md' 
                          : 'terms_and_conditions_pl.md',
                      typeOfDialogText: l10n.termsAndConditionsTitle,
                    ),
                  ),
            ),
            TextSpan(text: l10n.agreeToTermsPart2),
            TextSpan(
              text: l10n.policies,
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.isIOS
                  ? showModalBottomSheet<void>(
                    backgroundColor: AppColors.transparent,
                    isScrollControlled: true,
                    elevation: 0,
                    context: context, 
                    builder: (context) => AgreeInfoModal(
                      mdFileName: context
                        .read<LanguageProvider>()
                        .currentLocale
                        .languageCode == 'en' 
                          ? 'privacy_policy.md' 
                          : 'privacy_policy_pl.md',
                      typeOfDialogText: l10n.privacyPolicyTitle,
                    )
                  )
                  : showDialog<void>(
                    context: context, 
                    builder: (context) => AgreeInfoDialog(
                      mdFileName: context
                        .read<LanguageProvider>()
                        .currentLocale
                        .languageCode == 'en' 
                          ? 'privacy_policy.md' 
                          : 'privacy_policy_pl.md',
                      typeOfDialogText: l10n.privacyPolicyTitle,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
