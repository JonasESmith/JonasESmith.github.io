import '../core.dart';

class ImageIconColored extends StatelessWidget {
  const ImageIconColored({
    super.key,
    required this.url,
    this.subtractSize = 0.0,
    this.size = 30,
    this.color,
  });

  final String url;
  final double subtractSize;
  final int size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLight = brightness == Brightness.dark;
    // final isLight = Theme.of(context)
    final theme = Theme.of(context);

    final iconColor = theme.colorScheme.primary.computeLuminance() > 0.5 //
        ? Colors.black87
        : Colors.white70;

    return ColorFiltered(
      colorFilter: !isLight
          ? ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            )
          : ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
      child: Image.asset(
        url,
        width: size - subtractSize,
        height: size - subtractSize,
      ),
    );
  }
}
