import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:portfolio/src/core/widgets/page_wrapper.dart';
import 'package:portfolio/src/projects/projects.dart';
import 'package:provider/provider.dart';

import '../core/core.dart';

/// Creates an example mail page using [AdaptiveLayout].
class MyHomePage extends StatefulWidget {
  /// Creates a const [MyHomePage].
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with
        TickerProviderStateMixin, //
        ChangeNotifier {
  // The index of the selected mail card.
  int? selected;

  void selectCard(int? index) {
    setState(() {
      selected = index;
    });
  }

  ScrollController controller = ScrollController();

  late bool showFollower;
  late double followerOpacity;

  // bug here causing the _navindex to be incorrectly set when switching between
  // the mobile view and the larger desktop view. we should check for this.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppData>(context);

    return const ProjectsPage();
  }
}
