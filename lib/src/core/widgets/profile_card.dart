import 'dart:ui';

import 'package:portfolio/src/about/about.dart';
import 'package:provider/provider.dart';

import '../core.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appData = Provider.of<AppData>(context);
    final profile = appData.profile;

    return VoxButton(
      onPressed: () {
        /// lets "pop" up, with a hero to show this little thing navigate
        /// better.
        Navigator.push(
          context,
          HeroDialogRoute(
            builder: (BuildContext context) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  content: Hero(
                    tag: "profile hero baby",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kPad * 1),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: kPad * 100,
                          sigmaY: kPad * 100,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 500,
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor.withOpacity(0.87),
                              border: Border.all(color: theme.colorScheme.primary),
                              borderRadius: BorderRadius.circular(kPad),
                            ),
                            child: SingleChildScrollView(
                              child: AboutPage.profileWidget(
                                profile: profile,
                                context: context,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Hero(
        tag: "profile hero baby",
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              // color: theme.colorScheme.primary.withOpacity(0.2),
              border: Border.all(color: theme.colorScheme.tertiary.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(kPad),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.secondary.withOpacity(0.1),
                  theme.colorScheme.tertiary.withOpacity(0.1),
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: kPad / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const VPad.half(),
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(kPad * 0.5),
                    child: Image.asset(
                      key: Key(profile.imagePath),
                      fit: BoxFit.cover,
                      profile.imagePath,
                    ),
                  ),
                ),
                const VPad.half(),
                Text(
                  profile.name,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 15,
                  ),
                ),
                const VPad.half(),
                Container(
                  padding: const EdgeInsets.all(kPad / 2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.tertiary.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(kPad / 2),
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.05),
                        theme.colorScheme.tertiary.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About me!",
                        style: theme.textTheme.bodyMedium,
                      ),
                      Icon(
                        Icons.exit_to_app_outlined,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                const VPad.half(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
