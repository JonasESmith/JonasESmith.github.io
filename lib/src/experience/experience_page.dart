import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:vox_widgets/vox_widgets.dart';

/// [ExperiencePage] the display page for this feature
class ExperiencePage extends StatelessWidget {
  /// [ExperiencePage] constructor.
  const ExperiencePage({super.key});

  /// [routeName] the route name for this page
  static const routeName = '/experience';

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
