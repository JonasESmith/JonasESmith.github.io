import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

/// [SettingsPage] the display page for this feature
class SettingsPage extends StatelessWidget {
  /// [SettingsPage] constructor.
  const SettingsPage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/settings';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route() {
    Modular.to.pushNamed(routeName);
  }

  static Widget settings({
    required BuildContext context,
  }) {
    final appModel = Provider.of<AppData>(context, listen: true);
    final theme = Theme.of(context);
    final themeController = Provider.of<ThemeController>(context);
    final isLight = themeController.themeMode == ThemeMode.light;

    var themes = [...AppColor.customSchemes];

    final followerOpacity = appModel.mouseFollowerOpacity;

    return BlocBuilder<HomeBloc, HomeState>(
      bloc: Modular.get<HomeBloc>(),
      builder: (context, state) {
        AppData? model;

        state.whenOrNull(
          loaded: (AppData data) {
            model = data;
          },
        );

        return Column(
          children: [
            const VPad(),
            VoxLabeledCustomInputField(
              label: "Cursor Shadow",
              data: appModel.showMouseFollower ? "Hide" : "Show",
              onPressed: () {
                Modular.get<HomeBloc>().add(
                  HomeEvent.updateModel(
                    data: model!.copyWith(
                      showMouseFollower: !appModel.showMouseFollower,
                    ),
                  ),
                );
              },
            ),
            if (appModel.showMouseFollower) ...{
              const VPad(),
              VoxLabeledSlider(
                label: "opacity",
                labelWidth: 70,
                value: model!.mouseFollowerOpacity,
                min: 0.01,
                max: 0.4,
                onPressed: (value) {
                  Modular.get<HomeBloc>().add(
                    HomeEvent.updateModel(
                      data: model!.copyWith(
                        mouseFollowerOpacity: value,
                      ),
                    ),
                  );
                },
              ),
            },
            const VPad.half(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kPad / 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VPad.half(),
                  VoxButton(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kPad / 2),
                          border: Border.all(
                            color: theme.colorScheme.primary,
                          )),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kPad / 4),
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              isLight //
                                  ? CupertinoIcons.moon
                                  : CupertinoIcons.sun_dust,
                              size: 30,
                            ),
                          ),
                          const HPad(),
                          Expanded(
                            child: Text(!isLight ? "Light Theme" : "Dark Theme"),
                          ),
                          Container(
                            height: 50,
                            width: kPad / 2,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(kPad),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();

                      // Set theme-mode light/dark
                      if (isLight) {
                        themeController.setThemeMode(ThemeMode.dark);
                      } else {
                        themeController.setThemeMode(ThemeMode.light);
                      }
                    },
                  ),
                  const VPad.half(),
                  ColorThemeListTile(
                    index: themeController.schemeIndex,
                    themeData: themes[themeController.schemeIndex],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: theme.dividerColor,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  right: kPad,
                  left: kPad / 4,
                  bottom: kPad * kPad,
                ),
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  return ColorThemeListTile(
                    index: index,
                    themeData: themes[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return VoxScaffold(
      backGroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPad),
        child: SettingsPage.settings(
          context: context,
        ),
      ),
    );
  }
}
