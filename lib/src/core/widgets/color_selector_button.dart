import 'package:flutter_bloc/flutter_bloc.dart';

import '../core.dart';

class ColorSelectorButton extends StatelessWidget {
  const ColorSelectorButton({
    super.key,
    required this.index,
    required this.themeData,
  });

  final int index;
  final FlexSchemeData themeData;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final theme = Theme.of(context);

    bool isLight = themeController.themeMode == ThemeMode.light;

    final primary = isLight ? themeData.light.primary : themeData.dark.primary;
    final seconary = isLight ? themeData.light.secondary : themeData.dark.secondary;
    final terrtiary = isLight ? themeData.light.tertiary : themeData.dark.tertiary;
    final sbgColor = isLight ? themeData.light.appBarColor : themeData.dark.appBarColor;

    return Container(
      padding: const EdgeInsets.all(kPad / 4),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kPad / 4),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
        children: [
          Container(
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(kPad / 8),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: seconary,
              borderRadius: BorderRadius.circular(kPad / 8),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: terrtiary,
              borderRadius: BorderRadius.circular(kPad / 8),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: sbgColor,
              borderRadius: BorderRadius.circular(kPad / 8),
            ),
          ),
        ],
      ),
    );
  }
}
