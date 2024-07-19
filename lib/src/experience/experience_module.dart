import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/experience/experience.dart';

/// [ExperienceModule] is a [Module] that provides the application's dependencies.
class ExperienceModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<AppBloc>(() => AppBloc()..add(const AppEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const ExperiencePage(),
    );
  }
}
