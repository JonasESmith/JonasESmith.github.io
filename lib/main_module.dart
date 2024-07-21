import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/about/about.dart';
import 'package:portfolio/src/experience/experience.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:portfolio/src/home/home.dart';
import 'package:portfolio/src/project/project.dart';
import 'package:portfolio/src/projects/projects.dart';
import 'package:portfolio/src/settings/settings.dart';
import 'package:portfolio/src/skills/skills.dart';
import 'package:provider/provider.dart';

/// [MainModule] is a [Module] that provides the application's dependencies.
class MainModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeBloc>(() => HomeBloc() //
      ..add(const HomeEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => BlocBuilder<HomeBloc, HomeState>(
        bloc: Modular.get<HomeBloc>(),
        builder: (context, state) {
          return state.when(
            uninitialized: () => const SizedBox(),
            loaded: (data) => Provider.value(
              value: data,
              child: const MyHomePage(),
            ),
          );
        },
      ),
      children: [
        ModuleRoute(AboutPage.routeName, module: AboutModule()),
        ModuleRoute(SkillsPage.routeName, module: SkillsModule()),
        ModuleRoute(ProjectPage.routeName, module: ProjectModule()),
        ModuleRoute(SettingsPage.routeName, module: SettingsModule()),
        ModuleRoute(ProjectsPage.routeName, module: ProjectsModule()),
        ModuleRoute(ExperiencePage.routeName, module: ExperienceModule()),
        // WildcardRoute(child: (_) => const ProjectsPage())
      ],
      transition: TransitionType.noTransition,
    );
  }
}
