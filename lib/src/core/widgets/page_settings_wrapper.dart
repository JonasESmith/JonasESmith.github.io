import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart' hide ModularWatchExtension;
import 'package:portfolio/src/core/core.dart';
import 'package:portfolio/src/core/utils/utils.dart';
import 'package:portfolio/src/home/bloc/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PageSettingsWrapper extends StatefulWidget {
  const PageSettingsWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PageSettingsWrapper> createState() => _PageSettingsWrapperState();
}

class _PageSettingsWrapperState extends State<PageSettingsWrapper> {
  final FocusNode _focusNode = FocusNode();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _openSearch({
    required AppData appData,
  }) {
    Modular.get<HomeBloc>().add(
      HomeEvent.updateModel(
        data: appData.copyWith(
          isSearchOpen: true,
        ),
      ),
    );

    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _closeSearch({
    required AppData appData,
  }) {
    Modular.get<HomeBloc>().add(
      HomeEvent.updateModel(
        data: appData.copyWith(
          isSearchOpen: false,
        ),
      ),
    );

    /// lets focus on our focus node
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.read<ThemeController>();
    final themes = AppColor.customSchemes;
    final appData = Provider.of<AppData>(context);

    log("Is search open : ${appData.isSearchOpen}");

    return KeyboardListener(
      key: const Key("CUNT_FUCKING_DICK_HEAD_SETTINGS_PAGE"),
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event.runtimeType == KeyDownEvent &&
            HardwareKeyboard
                .instance //
                .logicalKeysPressed
                .contains(LogicalKeyboardKey.metaLeft) &&
            event.logicalKey == LogicalKeyboardKey.keyP) {
          if (appData.isSearchOpen) {
            _closeSearch(appData: appData);
          } else {
            _openSearch(appData: appData);
          }
        }

        if (event.runtimeType == KeyDownEvent &&
            HardwareKeyboard
                .instance //
                .logicalKeysPressed
                .contains(LogicalKeyboardKey.escape)) {
          if (appData.isSearchOpen) {
            _closeSearch(appData: appData);
          }
        }

        if (event.runtimeType == KeyDownEvent && //
            event.logicalKey == LogicalKeyboardKey.arrowDown) {
          final index = themeController.schemeIndex;
          final next = index + 1;

          if ((next) < themes.length) {
            if (next < (themes.length - 9) && next - 2 > 0) {
              log("$next < ${themes.length - 9}");
              itemScrollController.scrollTo(
                index: next - 2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }

            themeController.setSchemeIndex(next);
          }
        }

        if (event.runtimeType == KeyDownEvent && //
            event.logicalKey == LogicalKeyboardKey.arrowUp) {
          final index = themeController.schemeIndex;
          final next = index - 1;

          if ((next) >= 0) {
            if (next < (themes.length - 9) && next - 2 > 0) {
              log("$next < ${themes.length - 9}");

              itemScrollController.scrollTo(
                index: next - 2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
            themeController.setSchemeIndex(next);
          }
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            widget.child,
            if (appData.isSearchOpen)
              SearchWidget(
                appData: appData,
                onClose: () => _closeSearch(appData: appData),
                itemScrollController: itemScrollController,
                schemaIndexChanged: (int next) {
                  if ((next) < themes.length - 1 && (next) >= 0) {
                    if (next < (themes.length - 9) && next - 2 > 0) {
                      log("$next < ${themes.length - 9}");
                      itemScrollController.scrollTo(
                        index: next - 2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    themeController.setSchemeIndex(next);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  void updateIndex() {}
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.onClose,
    required this.itemScrollController,
    required this.schemaIndexChanged,
    required this.appData,
  });

  final VoidCallback onClose;
  final ItemScrollController itemScrollController;
  final Function(int) schemaIndexChanged;
  final AppData appData;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  String query = "";
  List<Map<String, dynamic>> ourFiles = [];

  @override
  void initState() {
    super.initState();
    // Request focus on the text field when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = context.watch<ThemeController>();

    final themes = [...AppColor.customSchemes];

    bool isLight = themeController.themeMode == ThemeMode.light;
    final selectedIndex = themeController.schemeIndex;

    final size = MediaQuery.of(context).size;

    final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
    final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

    return GestureDetector(
      onTap: () => widget.onClose(),
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: kPad),
          child: GestureDetector(
            onTap: () {},
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Container(
                width: 600,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(
                    kPad / 1.2,
                  ),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: theme.shadowColor.withOpacity(0.2),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(kPad / 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoSearchTextField(
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            style: theme.textTheme.bodyMedium,
                            onChanged: (value) {
                              setState(() {
                                query = value;
                              });
                            },
                          ),
                        ),
                        const HPad.quarter(),
                        Row(
                          children: [
                            Tooltip(
                              message: "Arrow Key Up",
                              child: VoxButton(
                                onPressed: () {
                                  widget.schemaIndexChanged(selectedIndex - 1);
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(kPad / 2),
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withOpacity(0.3),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(kPad / 4),
                                  child: const Icon(
                                    CupertinoIcons.arrow_up,
                                    size: kPad,
                                  ),
                                ),
                              ),
                            ),
                            const HPad.quarter(),
                            Tooltip(
                              message: "Arrow Key Down",
                              child: VoxButton(
                                onPressed: () {
                                  widget.schemaIndexChanged(selectedIndex + 1);
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(kPad / 2),
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withOpacity(0.3),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(kPad / 4),
                                  child: const Icon(
                                    CupertinoIcons.arrow_down,
                                    size: kPad,
                                  ),
                                ),
                              ),
                            ),
                            const HPad.quarter(),
                            VoxButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();

                                // Set theme-mode light/dark
                                if (isLight) {
                                  themeController.setThemeMode(ThemeMode.dark);
                                } else {
                                  themeController.setThemeMode(ThemeMode.light);
                                }
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(kPad / 2),
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withOpacity(0.3),
                                  ),
                                ),
                                padding: const EdgeInsets.all(kPad / 4),
                                child: Icon(
                                  isLight //
                                      ? CupertinoIcons.moon
                                      : CupertinoIcons.sun_dust,
                                  size: kPad,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const VPad.quarter(),
                    Container(
                      height: 1,
                      width: 600,
                      color: theme.dividerColor,
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: ScrollablePositionedList.builder(
                        itemCount: themes.length,
                        initialScrollIndex: selectedIndex,
                        itemBuilder: (context, index) {
                          final themeData = themes[index];

                          final primary = isLight ? themeData.light.primary : themeData.dark.primary;
                          final secondary = isLight ? themeData.light.secondary : themeData.dark.secondary;
                          final terrtiary = isLight ? themeData.light.tertiary : themeData.dark.tertiary;

                          final isSelected = selectedIndex == index;

                          final name = themeData.name.replaceAll("Example", "");

                          final keyWords = KeywordsUtil.generate(
                            keyWords: name.split(" "),
                          );

                          final isSearched = keyWords.contains(query);

                          if (query.isNotEmpty && isSearched == false) {
                            return const SizedBox();
                          }

                          return VoxButton(
                            onPressed: () {
                              themeController.setSchemeIndex(index);

                              // Modular.get<HomeBloc>().add(
                              //   HomeEvent.updateModel(
                              //     data: widget.appData.copyWith(
                              //       isSearchOpen: false,
                              //     ),
                              //   ),
                              // );

                              // FocusScope.of(context).unfocus();
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
                        itemScrollController: widget.itemScrollController,
                        scrollOffsetController: scrollOffsetController,
                        itemPositionsListener: itemPositionsListener,
                        scrollOffsetListener: scrollOffsetListener,
                      ),
                    ),
                    // Add your search results or other widgets here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
