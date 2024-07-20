// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/core/utils/utils.dart';
import 'package:portfolio/src/core/widgets/page_wrapper.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:portfolio/src/projects/projects.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// [ProjectPage] the display page for this feature
class ProjectPage extends StatefulWidget {
  /// [ProjectPage] constructor.
  const ProjectPage({
    super.key,
    required this.project,
  });

  final Project project;

  /// [routeName] the route name for this page
  static const routeName = '/project';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route({
    required AppData data,
    required Project project,
    required BuildContext context,
  }) {
    /// lets create our custom title
    final title = UrlUtil.cleanUrlTitle(title: project.title);

    List<String>? visited = [...data.visited ?? []];

    final index = visited.indexWhere((e) => e == project.title);

    if (index == -1) {
      visited.add(project.title);

      /// we could attempt to update our module here also
      Modular.get<HomeBloc>().add(
        HomeEvent.updateModel(
          data: data.copyWith(
            visited: visited,
          ),
        ),
      );
    }

    context.go(
      Uri(
        path: '/project/$title',
      ).toString(),
    );

    // Modular.to.pushNamed(
    //   "$routeName/$title",
    // );
  }

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  late AnimationController _controller;
  late Animation<double> _topBarAnimation;
  late Animation<double> _imageGalleryAnimation;
  late Animation<double> _descriptionAnimation;

  @override
  void dispose() {
    // Stop the animation if it's still running
    _controller.stop();

    // Dispose of the controller
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.7,
          curve: Curves.easeOut,
        ),
      ),
    );

    _imageGalleryAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.2,
          0.9,
          curve: Curves.easeOut,
        ),
      ),
    );

    _descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.4,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 600), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VoxScaffold(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: SizedBox(
                width: 900.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kPad / 2,
                        right: kPad / 2,
                        top: kPad / 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VPad(),
                          const VPad.half(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  VoxButton(
                                    child: Container(
                                      padding: const EdgeInsets.all(kPad / 2),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withOpacity(0.1),
                                        border: Border(
                                          left: BorderSide(color: theme.dividerColor),
                                          top: BorderSide(color: theme.dividerColor),
                                          bottom: BorderSide(color: theme.dividerColor),
                                          right: BorderSide(color: theme.dividerColor),
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(kPad),
                                          bottomLeft: Radius.circular(kPad),
                                        ),
                                      ),
                                      child: const Icon(CupertinoIcons.chevron_back),
                                    ),
                                    onPressed: () {
                                      // if (Navigator.of(context).canPop()) {
                                      context.go("/");
                                      // } else {
                                      //   // ProjectsPage.route();

                                      // }
                                    },
                                  ),
                                  VoxButton(
                                    onPressed: widget.project.url != null
                                        ? () async {
                                            final uri = Uri.parse(widget.project.url!);

                                            /// maybe nav
                                            if (!await launchUrl(uri)) {}
                                          }
                                        : null,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: kPad / 2,
                                        vertical: (kPad / 2) + -2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withOpacity(0.1),
                                        border: Border(
                                          top: BorderSide(color: theme.dividerColor),
                                          bottom: BorderSide(color: theme.dividerColor),
                                          right: BorderSide(color: theme.dividerColor),
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(kPad),
                                          bottomRight: Radius.circular(kPad),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            widget.project.title,
                                            style: theme.textTheme.titleLarge!.copyWith(
                                              color: widget.project.url != null //
                                                  ? theme.colorScheme.primary
                                                  : null,
                                            ),
                                          ),
                                          if (widget.project.url != null) ...{
                                            const HPad.half(),
                                            const HPad.quarter(),
                                            Icon(
                                              CupertinoIcons.link,
                                              color: theme.colorScheme.primary,
                                            ),
                                          },
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ProjectPlatformList(
                                  platforms: widget.project.platforms,
                                ),
                              ),
                            ],
                          ),
                          const VPad(),
                          FadeTransition(
                            opacity: _topBarAnimation,
                            child: TechnologyWrapper(
                              label: "Technologies",
                              technologies: widget.project.technologies,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VPad(),
                    FadeTransition(
                      opacity: _imageGalleryAnimation,
                      child: ProjectImageGallery(
                        images: widget.project.imgUrls,
                        projectName: widget.project.title,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kPad / 2,
                        right: kPad,
                        top: kPad / 2,
                      ),
                      child: Column(
                        children: [
                          const Divider(),
                          FadeTransition(
                            opacity: _descriptionAnimation,
                            child: VoxMarkdown(
                              content: widget.project.content,
                            ),
                          ),
                          const SizedBox(
                            height: kPad * kPad,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
