import 'package:portfolio/src/core/widgets/page_wrapper.dart';
import 'package:provider/provider.dart';

import '../core.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return PageWrapper(
      child: VoxMouseFollower(
        colorOpacity: appData.mouseFollowerOpacity,
        enabled: appData.showMouseFollower,
        child: PageSettingsWrapper(
          child: child,
        ),
      ),
    );
  }
}
