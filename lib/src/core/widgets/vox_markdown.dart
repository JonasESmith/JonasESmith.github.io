import 'package:flutter/cupertino.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:portfolio/src/core/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

class VoxMarkdown extends StatelessWidget {
  const VoxMarkdown({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
    final appData = Provider.of<AppData>(context);

    final data = Provider.of<AppData>(context);

    codeWrapper(child, text, language) => CodeWrapperWidget(child, text, language);

    return MarkdownWidget(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      data: content,
      config: config.copy(
        configs: [
          PConfig(
            textStyle: theme.textTheme.bodySmall!,
          ),
          BlockquoteConfig(
            sideColor: theme.colorScheme.tertiary,
            textColor: theme.textTheme.titleLarge!.color!,
          ),
          LinkConfig(
            style: const TextStyle(
              color: CupertinoColors.activeBlue,
              decoration: TextDecoration.underline,
              decorationColor: CupertinoColors.activeBlue,
            ),
            onTap: (url) async {
              if (url.contains("/project/")) {
                final name = url.replaceAll("/project/", "");

                final pName = UrlUtil.decodeUrlTitle(title: name);
                final project = data //
                    .projects
                    .where((e) => e.title.toLowerCase() == pName.toLowerCase())
                    .first;
                ProjectPage.route(
                  project: project,
                  data: appData,
                );
                return;
              }

              final uri = Uri.parse(url);

              /// maybe nav
              if (!await launchUrl(uri)) {}
            },
          ),
          isDark //
              ? PreConfig.darkConfig.copy(
                  decoration: BoxDecoration(
                    // color: theme.cardColor,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(kPad / 2),
                  ),
                  wrapper: codeWrapper,
                )
              : const PreConfig().copy(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(kPad / 2),
                  ),
                  wrapper: codeWrapper,
                ),
        ],
      ),
    );
  }
}
