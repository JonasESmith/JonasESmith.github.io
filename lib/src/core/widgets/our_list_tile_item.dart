import '../core.dart';

class OurListTileItem extends StatelessWidget {
  const OurListTileItem({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VoxButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
        ),
        margin: const EdgeInsets.all(kPad / 2),
        padding: const EdgeInsets.all(kPad),
        child: child,
      ),
    );
  }
}
