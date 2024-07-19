import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/settings/settings_page.dart';

/// [SettingsModule] is a [Module] that provides the application's dependencies.
class SettingsModule extends Module {
  @override
  void binds(Injector i) {
    // i.addLazySingleton<AppBloc>(() => AppBloc()..add(const AppEvent.started()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const SettingsPage(),
    );
  }
}
