// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:provider/provider.dart';

/// [SkillsPage] the display page for this feature
class SkillsPage extends StatelessWidget {
  /// [SkillsPage] constructor.
  const SkillsPage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/skills';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route() {
    Modular.to.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppData>(context);
    final skills = model.skills;
    final theme = Theme.of(context);

    return VoxScaffold(
      backGroundColor: Colors.transparent,
      child: ListView.builder(
        cacheExtent: 9999,
        padding: const EdgeInsets.only(
          top: kPad,
          left: kPad / 2,
          right: kPad / 2,
          bottom: kPad * 20,
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skill = skills[index];

          final sub_skills = skill.skills ?? [];
          final sub_techs = sub_skills //
              .map((e) => Technology(label: e.name))
              .toList();

          var skill_start = calculateYearsOfExperience(
            skill.startMsse.toString(),
          );

          if (skill.endMsse != null) {
            skill_start = calculateDuration(
              skill.startMsse!,
              skill.endMsse!,
            );
          }

          return OurListTileItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                child: skill.url != null
                                    ? ImageIconColored(url: skill.url!)
                                    : const Icon(
                                        CupertinoIcons.hammer,
                                      ),
                              ),
                              const HPad.half(),
                              Expanded(
                                child: AutoSizeText(
                                  skill.name,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    kPad / 2,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary.withOpacity(0.1),
                                      theme.colorScheme.secondary.withOpacity(0.1),
                                      theme.colorScheme.tertiary.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(kPad / 4),
                                child: Row(
                                  children: [
                                    const HPad.half(),
                                    Text(
                                      "$skill_start years experience",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    const HPad.half(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const VPad.quarter(),
                          VoxMarkdown(
                            content: skill.content,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (sub_skills.isNotEmpty) ...{
                  const VPad.half(),
                  TechnologyWrapper(
                    label: "Sub-Skills",
                    technologies: sub_techs,
                  ),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  String calculateYearsOfExperience(String startMsse) {
    final startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(startMsse));
    final now = DateTime.now();
    final difference = now.difference(startDate);

    // Convert the difference to years with two decimal places
    final years = difference.inDays / 365.25;
    return years.toStringAsFixed(1);
  }

  String calculateDuration(String startMsse, String endMsse) {
    final startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(startMsse));
    final endDate = DateTime.fromMillisecondsSinceEpoch(int.parse(endMsse));
    final difference = endDate.difference(startDate);

    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;

    if (years > 0 && months > 0) {
      return '$years year${years > 1 ? 's' : ''}, $months month${months > 1 ? 's' : ''}';
    } else if (years > 0) {
      return '$years year${years > 1 ? 's' : ''}';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return 'Less than a month';
    }
  }
}
