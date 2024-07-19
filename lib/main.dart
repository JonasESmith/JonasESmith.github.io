import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio/main_module.dart';
import 'package:portfolio/main_page.dart';
import 'package:url_strategy/url_strategy.dart';

import 'src/core/core.dart';

Future<void> main() async {
  setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  final themeService = ThemeServiceHive(boxName: 'color_theme_hive');
  // Initialize the theme service.
  await themeService.init();
  // Create a ThemeController that uses the ThemeService.
  final ThemeController themeController = ThemeController(themeService);
  // Load preferred theme settings, while the app is loading, before MaterialApp
  // is created, this prevents a theme change when the app is first displayed.
  await themeController.loadAll();

  themeController.setSchemeIndex(0);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb //
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  ///

  runApp(
    ModularApp(
      module: MainModule(),
      child: MainPage(controller: themeController),
    ),
  );
}
