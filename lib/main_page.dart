import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/core/utils/utils.dart';
import 'package:portfolio/src/core/widgets/app_shell.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:portfolio/src/home/home.dart';
import 'package:provider/provider.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            redirect: (_, __) => '/home',
          ),
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
              context: context,
              state: state,
              child: const MyHomePage(),
            ),
          ),
          GoRoute(
            path: '/project/:id',
            pageBuilder: (context, state) {
              final data = Provider.of<AppData>(context);
              final projectId = state.pathParameters['id'];

              log("Project ID: $projectId");

              if (projectId != null) {
                final title = UrlUtil.decodeUrlTitle(title: projectId);
                final project = data.projects.firstWhere((e) => e.title == title, orElse: () => throw Exception('Project not found'));
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: ProjectPage(
                    project: project,
                  ),
                );
              } else {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const Center(
                    child: Text("Page not found"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: Modular.get<HomeBloc>(),
      builder: (context, state) {
        return state.when(
          uninitialized: () => const SizedBox(),
          loaded: (data) => Provider.value(
            value: data,
            child: ChangeNotifierProvider.value(
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
                    routerConfig: router,
                    debugShowCheckedModeBanner: false,
                    themeMode: themeController.themeMode,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
