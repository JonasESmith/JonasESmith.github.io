import 'package:flutter/cupertino.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class TechnologyWrapper extends StatelessWidget {
  const TechnologyWrapper({
    super.key,
    required this.technologies,
    this.label,
  });

  final List<Technology> technologies;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...{
          Text(
            label!,
            style: theme.textTheme.bodySmall,
          ),
          const VPad.half(),
        },
        Wrap(
          alignment: WrapAlignment.start,
          runSpacing: kPad / 2,
          children: [
            // ignore: lines_longer_than_80_chars
            for (var i = 0; i < technologies.length; i++)
              VoxChip(
                padding: const EdgeInsets.only(
                  right: kPad / 4,
                ),
                label: technologies[i].label,
                color: theme.colorScheme.primary,
                trailing: technologies[i].url != null //
                    ? const Icon(
                        CupertinoIcons.link,
                        size: 10,
                      )
                    : null,
                onPressed: technologies[i].url != null
                    ? () async {
                        final uri = Uri.parse(technologies[i].url!);

                        /// maybe nav
                        if (!await launchUrl(uri)) {}
                      }
                    : null,
              ),
          ],
        ),
      ],
    );
  }
}
