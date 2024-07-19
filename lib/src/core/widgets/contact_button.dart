import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.uri,
    required this.label,
    required this.iconData,
    this.isLeftToRight = true,
  });

  final Uri uri;
  final bool isLeftToRight;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return VoxButton(
      onPressed: () {
        launchUrl(uri);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border.all(
            color: theme.colorScheme.secondary.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(
            kPad,
          ),
          gradient: LinearGradient(
            begin: isLeftToRight ? Alignment.bottomLeft : Alignment.bottomRight,
            end: isLeftToRight ? Alignment.topRight : Alignment.topLeft,
            colors: [
              theme.colorScheme.primary.withOpacity(0.05),
              theme.colorScheme.tertiary.withOpacity(0.05),
            ],
          ),
        ),
        width: 220,
        height: 48,
        padding: const EdgeInsets.all(kPad / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AutoSizeText(
                label,
                maxLines: 1,
                minFontSize: 8,
              ),
            ),
            Icon(
              iconData,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
