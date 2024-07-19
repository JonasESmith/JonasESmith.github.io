import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/template/template_page.dart';

/// [TemplateModule] is a [Module] that provides the application's dependencies.
class TemplateModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<AppBloc>(() => AppBloc()..add(const AppEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const TemplatePage(),
    );
  }
}
