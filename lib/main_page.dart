import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          final theme = themeController.useFlexColorScheme //
              ? flexThemeLight(themeController)
              : themeDataLight(themeController);

          final dTheme = themeController.useFlexColorScheme //
              ? flexThemeDark(themeController)
              : themeDataDark(themeController);

          return MaterialApp.router(
            theme: theme,
            darkTheme: dTheme,
            title: 'Portfolio',
            debugShowCheckedModeBanner: false,
            routerConfig: Modular.routerConfig,
            themeMode: themeController.themeMode,
          );
        },
      ),
    );
  }
}
