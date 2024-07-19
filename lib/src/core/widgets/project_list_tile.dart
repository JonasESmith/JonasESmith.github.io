// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectListTile extends StatelessWidget {
  const ProjectListTile({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appData = Provider.of<AppData>(context);

    final startTime = DateTime.fromMillisecondsSinceEpoch(project.startMsse);
    String dateString = "${startTime.month}/${startTime.day}/${startTime.year}";

    int description_length = project.description.length > 116 //
        ? 116
        : project.description.length;

    return OurListTileItem(
      onPressed: () {
        ProjectPage.route(
          project: project,
          data: appData,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(kPad / 4),
                ),
                padding: const EdgeInsets.all(kPad / 4),
                // child: Image.asset(
                //   project.iconAssetPath,
                //   fit: BoxFit.contain,
                // ),
                child: ImageIconColored(
                  url: project.iconAssetPath,
                ),
              ),
              const HPad(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                project.title,
                                style: theme.textTheme.titleLarge!,
                                maxLines: 1,
                                minFontSize: 12,
                              ),
                              Text(
                                dateString,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ProjectPlatformList(platforms: project.platforms),
                            if (project.url != null) ...{
                              const HPad.half(),
                              VoxButton(
                                onPressed: project.url != null
                                    ? () async {
                                        final uri = Uri.parse(project.url!);

                                        /// maybe nav
                                        if (!await launchUrl(uri)) {}
                                      }
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.link,
                                    color: theme.disabledColor,
                                    size: 20,
                                  ),
                                ),
                              )
                            },
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: kPad / 4),
          if (project.description.length > 70) ...{
            Text(
              project.description.replaceRange(
                description_length,
                project.description.length,
                '...',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          } else ...{
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          },
          const SizedBox(height: 13),
          TechnologyWrapper(
            technologies: project.technologies,
          ),
          // const VPad(),
          // const Row(
          //   children: [
          //     ProjectDateView(
          //       label: "Start",
          //       data: "Started this summer",
          //       color: CupertinoColors.activeOrange,
          //     ),
          //     HPad(),
          //     ProjectDateView(
          //       label: "End",
          //       data: "in developement",
          //       color: CupertinoColors.activeBlue,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class ProjectDateView extends StatelessWidget {
  const ProjectDateView({
    super.key,
    this.color,
    required this.label,
    required this.data,
  });

  final Color? color;
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = theme.colorScheme.primary.withOpacity(0.05);
    final bColor = theme.colorScheme.primary.withOpacity(0.2);
    final _color = color ?? bgColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(kPad / 4),
        border: Border.all(color: bColor),
      ),
      padding: const EdgeInsets.all(kPad / 4),
      child: Row(
        children: [
          const HPad.half(),
          Container(
            height: kPad * 2.2,
            width: kPad / 2,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(kPad / 4),
              border: Border.all(color: bColor),
            ),
          ),
          const HPad.half(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.titleLarge,
              ),
              Text(
                data,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const HPad(),
        ],
      ),
    );
  }
}
