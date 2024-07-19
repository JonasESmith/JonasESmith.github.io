import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/code_block.dart';
import 'package:markdown_widget/widget/blocks/leaf/link.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// [AboutPage] the display page for this feature
class AboutPage extends StatelessWidget {
  /// [AboutPage] constructor.
  const AboutPage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/about';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route() {
    Modular.to.pushNamed(routeName);
  }

  static Widget profileWidget({
    required Profile profile,
    required BuildContext context,
    bool showClose = true,
  }) {
    final theme = Theme.of(context);

    final isMobile = !Breakpoints.mediumAndUp.isActive(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config = isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (!showClose) ...{
          const VPad.quadruple(),
        },
        SizedBox(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: showClose
                    ? const BorderRadius.only(
                        topRight: Radius.circular(kPad - 2),
                        topLeft: Radius.circular(kPad - 2),
                      )
                    : BorderRadius.circular(kPad * 100),
                child: Image.asset(
                  key: Key(profile.imagePath),
                  fit: BoxFit.cover,
                  profile.imagePath,
                  height: 500,
                  width: 500,
                ),
              ),
              if (showClose)
                Positioned(
                  right: kPad / 2,
                  top: kPad / 2,
                  child: VoxButton(
                    child: Container(
                      padding: const EdgeInsets.all(kPad / 2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.clear,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPad),
          child: Column(
            children: [
              const VPad.half(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    profile.name,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < profile.links.length; i++) ...{
                        VoxLinkIcon(
                          url: profile.links[i],
                          color: theme.colorScheme.primary,
                        ),
                      },
                      const HPad.quarter(),
                      IconButton(
                        onPressed: () {
                          final email = "${profile.email}?subject=Hello&body=I%20would%20love%20to%20speak%20soon!";

                          final uri = Uri.parse("mailto:$email");

                          launchUrl(uri);
                        },
                        icon: const Icon(CupertinoIcons.mail),
                      ),
                      const HPad.quarter(),
                    ],
                  ),
                ],
              ),
              const VPad.half(),
              Padding(
                padding: const EdgeInsets.only(right: kPad / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContactButton(
                      uri: Uri.parse(
                        "mailto:${profile.email}?subject=Hello&body=I%20would%20love%20to%20speak%20soon!",
                      ),
                      label: profile.email,
                      iconData: CupertinoIcons.at,
                    ),
                    ContactButton(
                      isLeftToRight: false,
                      uri: Uri.parse("tel:+${profile.phoneNumber}"),
                      label: profile.phoneNumber,
                      iconData: CupertinoIcons.phone,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const VPad.half(),
              MarkdownWidget(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                data: profile.description,
                config: config.copy(
                  configs: [
                    LinkConfig(
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                      onTap: (url) async {
                        final uri = Uri.parse(url);

                        /// maybe nav
                        if (!await launchUrl(uri)) {}
                      },
                    ),
                  ],
                ),
              ),
              const VPad(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppData>(context);

    return VoxScaffold(
      backGroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: AboutPage.profileWidget(
          profile: model.profile,
          context: context,
          showClose: false,
        ),
      ),
    );
  }
}
