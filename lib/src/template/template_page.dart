import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vox_widgets/vox_widgets.dart';

/// [TemplatePage] the display page for this feature
class TemplatePage extends StatelessWidget {
  /// [TemplatePage] constructor.
  const TemplatePage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/template';

  /// our route, this should generally use the modular route, and
  /// our basic route callable item
  static void route() {
    Modular.to.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const VoxScaffold(
      child: Text(
        routeName,
      ),
    );
  }
}
