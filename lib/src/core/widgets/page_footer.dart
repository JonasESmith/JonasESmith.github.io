// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_modular/flutter_modular.dart' hide ModularWatchExtension;
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

class PageFooter extends StatelessWidget {
  const PageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final themeController = context.watch<ThemeController>();
    bool isLight = themeController.themeMode == ThemeMode.light;
    final model = Provider.of<AppData>(context);
    final isMobile = !Breakpoints.mediumAndUp.isActive(context);

    final themes = [...AppColor.customSchemes];

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.3),
        border: Border(
          top: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: isMobile //
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BottomNavButton(
                    border: Border(
                      right: BorderSide(
                        color: theme.dividerColor,
                      ),
                    ),
                    onPressed: () {
                      // Set theme-mode light/dark
                      if (isLight) {
                        themeController.setThemeMode(ThemeMode.dark);
                      } else {
                        themeController.setThemeMode(ThemeMode.light);
                      }
                    },
                    label: isLight ? "Dark" : "Light",
                    trailing: Icon(
                      isLight ? CupertinoIcons.moon : CupertinoIcons.sun_dust,
                      size: kPad,
                      color: theme.colorScheme.onPrimary,
                    ),
                    color: theme.colorScheme.primary,
                  ),
                  Tooltip(
                    message: "Command+P",
                    child: BottomNavButton(
                      border: Border(
                        right: BorderSide(
                          color: theme.dividerColor,
                        ),
                      ),
                      onPressed: () {
                        if (!isMobile) {
                          Modular.get<HomeBloc>().add(
                            HomeEvent.updateModel(
                              data: model.copyWith(
                                isSearchOpen: true,
                              ),
                            ),
                          );

                          return;
                        }

                        _showThemeSelectionDialog(context, themes, themeController);
                      },
                      label: themes[themeController.schemeIndex] //
                          .name
                          .replaceAll("Example", ""),
                      trailing: const Icon(
                        CupertinoIcons.chevron_up_square_fill,
                        size: 16,
                      ),
                    ),
                  ),
                  BottomNavButton(
                    border: Border(
                      right: BorderSide(
                        color: theme.dividerColor,
                      ),
                    ),
                    onPressed: () {
                      Modular.get<HomeBloc>().add(
                        HomeEvent.updateModel(
                          data: model.copyWith(
                            showMouseFollower: !model.showMouseFollower,
                          ),
                        ),
                      );
                    },
                    label: "Mouse Shadow",
                    trailing: Icon(
                      model.showMouseFollower //
                          ? CupertinoIcons.cursor_rays
                          : CupertinoIcons.location_slash_fill,
                      size: 16,
                    ),
                  ),
                  if (kDebugMode) ...{
                    BottomNavButton(
                      border: Border(
                        right: BorderSide(
                          color: theme.dividerColor,
                        ),
                      ),
                      onPressed: () {
                        Modular.get<HomeBloc>() //
                            .add(const HomeEvent.reset());
                      },
                      label: "Reset",
                      trailing: const Icon(
                        CupertinoIcons.refresh,
                        size: 16,
                      ),
                    ),
                  },
                ],
              ),
              // Column(
              //   children: [
              //     for (int i = 0; i < widget.data.profile.links.length; i++) ...{
              //       VoxLinkIcon(
              //         url: widget.data.profile.links[i],
              //       ),
              //     },
              //     IconButton(
              //       onPressed: () {
              //         final email = "${widget.data.profile.email}?subject=Hello&body=I%20would%20love%20to%20speak%20soon!";

              //         final uri = Uri.parse("mailto:$email");

              //         launchUrl(uri);
              //       },
              //       icon: const Icon(CupertinoIcons.mail),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         final uri = Uri.parse("tel:+${widget.data.profile.phoneNumber}");

              //         launchUrl(uri);
              //       },
              //       icon: const Icon(CupertinoIcons.phone),
              //     ),
              //   ],
              // ),
              if (!isMobile)
                Row(
                  children: [
                    for (int i = 0; i < model.profile.links.length; i++) ...{
                      BottomNavButton(
                        onPressed: () {
                          final url = Uri.parse(model.profile.links[i]);

                          if (url.scheme == 'http' || url.scheme == 'https') {
                            launchUrl(url);
                          }
                        },
                        border: Border(
                          left: BorderSide(
                            color: theme.dividerColor,
                          ),
                        ),
                        label: model //
                            .profile
                            .links[i]
                            .replaceAll("https://", "")
                            .replaceAll("www.", "")
                            .split("/")[0],
                      ),
                    },
                    BottomNavButton(
                      onPressed: () {
                        final email = "${model.profile.email}?subject=Hello&body=I%20would%20love%20to%20speak%20soon!";

                        final uri = Uri.parse("mailto:$email");

                        launchUrl(uri);
                      },
                      border: Border(
                        left: BorderSide(
                          color: theme.dividerColor,
                        ),
                      ),
                      label: "email",
                    ),
                  ],
                ),
            ],
          ),
          if (isMobile) ...{
            Row(
              mainAxisAlignment: isMobile //
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < model.profile.links.length; i++) ...{
                  BottomNavButton(
                    onPressed: () {
                      final url = Uri.parse(model.profile.links[i]);

                      if (url.scheme == 'http' || url.scheme == 'https') {
                        launchUrl(url);
                      }
                    },
                    border: Border(
                      left: BorderSide(
                        color: theme.dividerColor,
                      ),
                    ),
                    label: model //
                        .profile
                        .links[i]
                        .replaceAll("https://", "")
                        .replaceAll("www.", "")
                        .split("/")[0],
                  ),
                },
              ],
            ),
          }
        ],
      ),
    );
  }

  void _showThemeSelectionDialog(
    BuildContext context,
    List<FlexSchemeData> themes,
    ThemeController themeController,
  ) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset topLeft = button.localToGlobal(Offset.zero);

    bool isLight = themeController.themeMode == ThemeMode.light;

    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
    final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

    final theme = Theme.of(context);

    int selectedIndex = themeController.schemeIndex;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Positioned(
                  left: topLeft.dx + 80,
                  top: topLeft.dy - 500,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(kPad / 4),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.dividerColor,
                        ),
                      ),
                      child: Container(
                        width: 300,
                        height: 500,
                        padding: const EdgeInsets.all(8),
                        child: ScrollablePositionedList.builder(
                          itemCount: themes.length,
                          initialScrollIndex: selectedIndex,
                          itemBuilder: (context, index) {
                            final themeData = themes[index];

                            final primary = isLight ? themeData.light.primary : themeData.dark.primary;
                            final secondary = isLight ? themeData.light.secondary : themeData.dark.secondary;
                            final terrtiary = isLight ? themeData.light.tertiary : themeData.dark.tertiary;

                            final isSelected = selectedIndex == index;

                            return VoxButton(
                              onPressed: () {
                                themeController.setSchemeIndex(index);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kPad / 2,
                                  vertical: kPad / 4,
                                ),
                                decoration: BoxDecoration(
                                  border: isSelected ? Border.all(color: theme.colorScheme.primary) : null,
                                  borderRadius: BorderRadius.circular(kPad / 4),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: primary,
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: secondary,
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: terrtiary,
                                        ),
                                      ],
                                    ),
                                    const HPad(),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(themeData.name.replaceAll("Example", "")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemScrollController: itemScrollController,
                          scrollOffsetController: scrollOffsetController,
                          itemPositionsListener: itemPositionsListener,
                          scrollOffsetListener: scrollOffsetListener,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.trailing,
    this.border,
  });

  final Widget? trailing;
  final String label;
  final Function() onPressed;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _color = color ?? theme.secondaryHeaderColor;

    return VoxButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          border: border,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kPad / 2,
          vertical: kPad / 4,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall!.copyWith(
                  color: _color.computeLuminance() <= 0.5 //
                      ? Colors.white
                      : Colors.black),
            ),
            if (trailing != null) ...{
              const HPad(),
              trailing!,
            }
          ],
        ),
      ),
    );
  }
}
