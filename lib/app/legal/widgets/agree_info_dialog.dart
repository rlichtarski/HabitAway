import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:habit_away/l10n/l10n.dart';

class AgreeInfoDialog extends StatelessWidget {
  final String mdFileName;
  final String typeOfDialogText;
  const AgreeInfoDialog({
    required this.mdFileName,
    required this.typeOfDialogText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(typeOfDialogText),
      content: FutureBuilder(
        future: Future<void>.delayed(
          const Duration(milliseconds: 150),
        ).then((value) {
          return rootBundle.loadString('assets/$mdFileName');
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              shrinkWrap: true,
              selectable: true,
              data: snapshot.data!,
            );
          }
          return const CircularProgressIndicator.adaptive();
        },
      ),
      actions: [
        TextButton(
          child: Text(l10n.ok,),
          onPressed: () => context.popNavigator(),
        ),
      ],
    );
  }
}
