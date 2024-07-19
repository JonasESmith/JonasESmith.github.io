import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:portfolio/src/project/project.dart';

import '../core/utils/utils.dart';

/// [ProjectModule] is a [Module] that provides the application's dependencies.
class ProjectModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<AppBloc>(() => AppBloc()..add(const AppEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/:project_name',
      child: (context) {
        final projectName = r.args.params['project_name'].toString();
        final title = UrlUtil.decodeUrlTitle(title: projectName);

        return BlocBuilder<HomeBloc, HomeState>(
          bloc: Modular.get<HomeBloc>(),
          builder: (context, state) {
            return state.when(
              uninitialized: () => const SizedBox(),
              loaded: (appData) {
                final projects = appData.projects;
                final project = projects.where((e) => e.title == title).first;

                return ProjectPage(project: project);
              },
            );
          },
        );
      },
    );
  }
}
