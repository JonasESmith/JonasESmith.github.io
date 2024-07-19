import 'package:flutter/services.dart';

import '../core.dart';

enum TabInputLayout {
  left,
  middle,
  right,
}

class SplitChipArea extends StatelessWidget {
  const SplitChipArea({
    super.key,
    required this.onPressed,
    required this.label,
    this.data = "",
    this.layout = TabInputLayout.middle,
    this.isSelected = false,
  });

  final Function() onPressed;
  final String label;
  final String data;
  final TabInputLayout layout;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const radius = kPad * 2;

    final isLeft = layout == TabInputLayout.left;
    final isRight = layout == TabInputLayout.right;
    final isMiddle = layout == TabInputLayout.middle;

    final color = isSelected //
        ? theme.colorScheme.primary.withOpacity(0.7)
        : theme.colorScheme.surface;

    final textColor = color.computeLuminance() < 0.5 //
        ? Colors.white
        : Colors.black;

    return Expanded(
      child: VoxButton(
        onPressed: () {
          HapticFeedback.lightImpact();

          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: isLeft || isMiddle ? BorderSide(color: theme.dividerColor) : BorderSide.none,
              top: BorderSide(color: theme.dividerColor),
              bottom: BorderSide(color: theme.dividerColor),
              right: isRight || isMiddle ? BorderSide(color: theme.dividerColor) : BorderSide.none,
            ),
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? const Radius.circular(radius) : Radius.zero,
              bottomLeft: isLeft ? const Radius.circular(radius) : Radius.zero,
              topRight: isRight ? const Radius.circular(radius) : Radius.zero,
              bottomRight: isRight ? const Radius.circular(radius) : Radius.zero,
            ),
            color: color,
          ),
          height: 50,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (data.isNotEmpty) ...{
                  Text(
                    data.toString(),
                    style: theme.textTheme.bodyLarge!.copyWith(color: textColor),
                  ),
                  Text(
                    label.toString(),
                    style: theme.textTheme.bodySmall!.copyWith(color: textColor),
                  ),
                } else ...{
                  Text(
                    label.toString(),
                    style: theme.textTheme.bodyLarge!.copyWith(color: textColor),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
