import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

class ProjectPlatformList extends StatelessWidget {
  const ProjectPlatformList({
    super.key,
    required this.platforms,
    this.allowClick = false,
  });

  final List<PlatForms>? platforms;
  final bool allowClick;

  @override
  Widget build(BuildContext context) {
    if (platforms == null && platforms!.isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: [
        for (int i = 0; i < platforms!.length; i++) ...{
          Padding(
            padding: const EdgeInsets.only(left: kPad / 4),
            child: getIconData(platforms![i]),
          ),
        },
      ],
    );
  }

  void urlLauncher(String? url) async {
    if (url == null && url!.isNotEmpty) {
      debugPrint("Nothing should happne...");
      return;
    }

    final uri = Uri.parse(url);

    /// maybe nav
    if (!await launchUrl(uri)) {}
  }

  Widget getIconData(PlatForms platform) {
    if (platform.iOs != null) {
      var url = platform.iOs!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.iOs!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: const Icon(
          Icons.apple,
        ),
      );
    }

    if (platform.web != null) {
      var url = platform.web!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.web!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: const Icon(
          FontAwesomeIcons.globe,
          size: 18,
        ),
      );
    }

    if (platform.iPad != null) {
      var url = platform.iPad!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.iPad!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.rectangle_outlined,
                size: 24,
              ),
            ),
            Icon(
              Icons.apple,
              size: 8,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
      );
    }

    if (platform.android != null) {
      var url = platform.android!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.android!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: const Icon(Icons.android),
      );
    }

    if (platform.windows != null) {
      var url = platform.windows!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.windows!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: const Icon(FontAwesomeIcons.windows),
      );
    }

    if (platform.linux != null) {
      return VoxButton(
        child: const Icon(FontAwesomeIcons.linux),
        onPressed: () {
          urlLauncher(platform.linux!.url);
        },
      );
    }

    if (platform.watch != null) {
      return VoxButton(
        child: const Icon(Icons.watch_sharp),
        onPressed: () {
          urlLauncher(platform.watch!.url);
        },
      );
    }

    if (platform.macOs != null) {
      var url = platform.macOs!.url;

      var onPressed = url != null
          ? () {
              urlLauncher(platform.macOs!.url);
            }
          : null;

      return VoxButton(
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const Icon(
              FontAwesomeIcons.desktop,
              size: 18,
            ),
            Positioned(
              top: 2,
              right: 4,
              child: Icon(
                Icons.apple,
                size: 8,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
