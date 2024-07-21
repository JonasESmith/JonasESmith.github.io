import '../core.dart';

class PageLeftTilda extends StatelessWidget {
  const PageLeftTilda({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: 20,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration //
                .of(context)
            .copyWith(scrollbars: false),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 60,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: kPad / 4,
                right: kPad / 4,
              ),
              child: Text(
                "~",
                style: theme.textTheme.bodyLarge,
              ),
            );
          },
        ),
      ),
    );
  }
}
