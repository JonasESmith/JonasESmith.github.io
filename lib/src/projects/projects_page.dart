// ignore_for_file: unnecessary_const, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/core/utils/utils.dart';
import 'package:portfolio/src/core/widgets/link_style_button.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

/// [ProjectsPage] the display page for this feature
class ProjectsPage extends StatefulWidget {
  /// [ProjectsPage] constructor.
  const ProjectsPage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/projects';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route() {
    final path = Modular.to.path;

    if (!path.contains("/projects")) {
      Modular.to.pushNamed(routeName);
    }
  }

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _profileAnimation;
  late Animation<double> _projectsAnimation;
  late Animation<double> _skillsAnimation;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _profileAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _projectsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _skillsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    final projects = appData.projects;
    final theme = Theme.of(context);

    final userAgeMSSE = DateTime.now().millisecondsSinceEpoch - //
        DateTime //
                .fromMillisecondsSinceEpoch(appData.profile.birthDate)
            .millisecondsSinceEpoch;

    final ageDuration = Duration(milliseconds: userAgeMSSE);

    final versionControl = TimeUtils.getTime(
      ageDuration,
      showSuffix: false,
      showSeconds: false,
      showMinutes: false,
    ).replaceAll(":", ".");

    var versions = versionControl.split(".");
    var finalVersion = "v${versions[0]}.${versions[1]}";

    final isMobile = !Breakpoints.mediumAndUp.isActive(context);

    const width = 500.0;

    return VoxScaffold(
      backGroundColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(
                    right: isMobile ? kPad / 2 : 0,
                  ),
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: kPad * 10,
                      ),
                      FadeTransition(
                        opacity: _profileAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -0.2),
                            end: Offset.zero,
                          ).animate(_profileAnimation),
                          child: Center(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaY: 10,
                                sigmaX: 10,
                              ),
                              child: VoxButton(
                                onPressed: () {
                                  Modular.get<HomeBloc>().add(
                                    HomeEvent.updateModel(
                                      data: appData.copyWith(
                                        isAboutMeOpen: !appData.isAboutMeOpen,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(kPad / 2),
                                    color: theme.colorScheme.primary.withOpacity(0.05),
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withOpacity(0.1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kPad / 2,
                                    vertical: kPad / 4,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(kPad * 3),
                                                    child: Image.asset(
                                                      key: Key(appData.profile.imagePath),
                                                      fit: BoxFit.cover,
                                                      appData.profile.imagePath,
                                                    ),
                                                  ),
                                                ),
                                                const HPad.half(),
                                                Text(
                                                  "JONAS.E.SMITH",
                                                  style: theme.textTheme.bodyLarge!.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            finalVersion,
                                            style: theme.textTheme.bodyLarge!.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const HPad.half(),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: theme.dividerColor,
                                              shape: BoxShape.circle,
                                            ),
                                            height: kPad * 2,
                                            width: kPad * 2,
                                            padding: const EdgeInsets.all(kPad / 8),
                                            child: Icon(
                                              !appData.isAboutMeOpen //
                                                  ? CupertinoIcons.chevron_down
                                                  : CupertinoIcons.chevron_up,
                                              color: theme.disabledColor,
                                              size: kPad,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (appData.isAboutMeOpen) ...{
                                        const Divider(),
                                        AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          child: appData.isAboutMeOpen
                                              ? VoxMarkdown(
                                                  key: UniqueKey(),
                                                  content: appData.profile.description,
                                                )
                                              : SizedBox(key: UniqueKey()),
                                        ),
                                      },
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Text(
                      //   appData.profile.description,
                      //   style: theme.textTheme.bodySmall,
                      // ),
                      const VPad(),
                      FadeTransition(
                        opacity: _projectsAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(_projectsAnimation),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: kPad / 4),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Noteable Projects",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            const VPad.half(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const HPad(),
                                  const Expanded(child: Divider()),
                                  const HPad.half(),
                                  Icon(
                                    CupertinoIcons.keyboard_chevron_compact_down,
                                    color: theme.disabledColor,
                                    size: kPad,
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: scrollController,
                                itemCount: projects.length,
                                itemBuilder: (context, index) {
                                  final project = projects[index];

                                  final hasVisited = appData.visited!.indexWhere(
                                        (e) => e == project.title,
                                      ) !=
                                      -1;

                                  return LinkStyleButton(
                                    label: project.title,
                                    hasBeenClicked: hasVisited,
                                    leading: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: hasVisited //
                                            // ? theme.colorScheme.primary
                                            // : theme.colorScheme.tertiary,
                                            ? CupertinoColors.systemPurple
                                            : CupertinoColors.activeBlue,
                                        borderRadius: BorderRadius.circular(kPad / 4),
                                      ),
                                      padding: const EdgeInsets.all(kPad / 8),
                                      // child: Image.asset(
                                      //   project.iconAssetPath,
                                      //   fit: BoxFit.contain,
                                      // ),
                                      child: ImageIconColored(
                                        url: project.iconAssetPath,
                                      ),
                                    ),
                                    onPressed: () {
                                      ProjectPage.route(
                                        data: appData,
                                        context: context,
                                        project: project,
                                      );
                                    },
                                    date: DateTime.fromMillisecondsSinceEpoch(
                                      project.startMsse,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VPad(),
                      FadeTransition(
                        opacity: _skillsAnimation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(_skillsAnimation),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: kPad / 4),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Skills",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            const VPad.half(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const HPad(),
                                  const Expanded(child: Divider()),
                                  const HPad.half(),
                                  Icon(
                                    CupertinoIcons.chart_bar_alt_fill,
                                    color: theme.disabledColor,
                                    size: kPad,
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                controller: scrollController,
                                itemCount: appData.skills.length,
                                itemBuilder: (context, index) {
                                  final skill = appData.skills[index];

                                  var skill_start = calculateYearsOfExperience(
                                    skill.startMsse.toString(),
                                  );

                                  if (skill.endMsse != null) {
                                    skill_start = calculateDuration(
                                      skill.startMsse!,
                                      skill.endMsse!,
                                    );
                                  }

                                  return LinkStyleButton(
                                    label: skill.name,
                                    hasBeenClicked: false,
                                    leading: Row(
                                      children: [
                                        const HPad.half(),
                                        Text(
                                          "$skill_start y",
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        const HPad.half(),
                                      ],
                                    ),
                                    onPressed: () {},
                                    date: DateTime.now(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kPad * 10,
                      ),
                    ],
                  ),
                ),
              ),
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
      return '$years${years > 1 ? '' : ''}';
    } else if (months > 0) {
      return '$months month${months > 1 ? 's' : ''}';
    } else {
      return 'Less than a month';
    }
  }
}
