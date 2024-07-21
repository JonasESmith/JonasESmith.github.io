import 'package:flutter/material.dart';
import 'package:portfolio/src/core/widgets/page_footer.dart';
import 'package:portfolio/src/core/widgets/page_left_tilda.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const PageLeftTilda(),
                Expanded(child: child),
              ],
            ),
          ),

          /// howdy
          const PageFooter(),
        ],
      ),
    );
  }
}
