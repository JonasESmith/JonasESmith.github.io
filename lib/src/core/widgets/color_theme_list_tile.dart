import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/src/core/core.dart';

class ColorThemeListTile extends StatelessWidget {
  const ColorThemeListTile({
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

    final isSelected = themeController.schemeIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: kPad / 2),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          ),
          color: isSelected ? theme.colorScheme.primary.withOpacity(0.2) : null,
          borderRadius: BorderRadius.circular(kPad / 2),
        ),
        child: VoxButton(
          onPressed: () {
            themeController.setThemeMode(isLight //
                ? ThemeMode.light
                : ThemeMode.dark);

            themeController.setSchemeIndex(index);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ColorSelectorButton(
                index: index,
                themeData: themeData,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(kPad / 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kPad / 4),
                  ),
                  child: Text(
                    themeData.name.replaceAll("Example", ""),
                    style: theme.textTheme.bodySmall!.copyWith(),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: kPad / 2,
                decoration: BoxDecoration(
                  color: isSelected //
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(kPad),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
