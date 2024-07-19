import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/projects/projects_page.dart';

/// [ProjectsModule] is a [Module] that provides the application's dependencies.
class ProjectsModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<AppBloc>(() => AppBloc()..add(const AppEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const ProjectsPage(),
      children: [
        /// our secondary viewer here should show a child possibly :)
      ],
    );
  }
}
