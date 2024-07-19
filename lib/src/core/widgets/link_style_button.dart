import 'package:flutter/cupertino.dart';
import 'package:portfolio/src/core/core.dart';

class LinkStyleButton extends StatefulWidget {
  const LinkStyleButton({
    super.key,
    required this.label,
    required this.hasBeenClicked,
    required this.date,
    required this.onPressed,
    this.leading,
  });

  final String label;
  final bool hasBeenClicked;
  final Widget? leading;
  final DateTime date;
  final Function() onPressed;

  @override
  State<LinkStyleButton> createState() => _LinkStyleButtonState();
}

class _LinkStyleButtonState extends State<LinkStyleButton> {
  Color bgColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onHover: (event) {
        setState(() {
          bgColor = theme.colorScheme.primary.withOpacity(0.2);
        });
      },
      onExit: (ev) {
        setState(() {
          bgColor = Colors.transparent;
        });
      },
      child: VoxButton(
        onPressed: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kPad / 4),
            color: bgColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: kPad / 2,
            vertical: kPad / 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: widget.hasBeenClicked //
                        ? CupertinoColors.systemPurple
                        : CupertinoColors.activeBlue,
                    color: widget.hasBeenClicked //
                        ? CupertinoColors.systemPurple
                        : CupertinoColors.activeBlue,
                  ),
                ),
              ),
              if (widget.leading != null) ...{
                widget.leading!,
                const HPad.half(),
              },
            ],
          ),
        ),
      ),
    );
  }
}
