import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vox_flex_theme/theme_controller.dart';
import 'package:vox_widgets/vox_widgets.dart';

class ToggleThemebutton extends StatelessWidget {
  const ToggleThemebutton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    bool isLight = themeController.themeMode == ThemeMode.light;

    return VoxToggleThemeButton(
      onPressed: () {
        HapticFeedback.lightImpact();

        // Set theme-mode light/dark
        if (isLight) {
          themeController.setThemeMode(ThemeMode.dark);
        } else {
          themeController.setThemeMode(ThemeMode.light);
        }
      },
      enabled: isLight,
      enabledIconData: CupertinoIcons.moon,
      disabledIconData: CupertinoIcons.sun_dust,
    );
  }
}
