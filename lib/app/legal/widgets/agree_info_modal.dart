import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AgreeInfoModal extends StatelessWidget {
  final String mdFileName;
  final String typeOfDialogText;
  const AgreeInfoModal({
    required this.mdFileName,
    required this.typeOfDialogText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.themeReference;
    final colors = theme.colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.popNavigator(),
      child: GestureDetector(
        onTap: () {  },
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ListView(
              controller: scrollController,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.xlg,
                        AppSpacing.lg, 
                        AppSpacing.lg,
                      ),
                      child: Text(
                        typeOfDialogText,
                        style: UITextStyle.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        AppSpacing.xlg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.close_fullscreen_outlined, 
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: Future<void>.delayed(
                    const Duration(milliseconds: 150),
                  ).then((value) {
                    return rootBundle.loadString('assets/$mdFileName');
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(
                        physics: const NeverScrollableScrollPhysics(),
                        selectable: true,
                        shrinkWrap: true,
                        data: snapshot.data!,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
