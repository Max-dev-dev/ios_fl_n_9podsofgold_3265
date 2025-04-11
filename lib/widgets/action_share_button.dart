import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ActionAppBar({super.key});

  void _shareApp(BuildContext context) {
    const String shareText = '''
"9 Gold Secrets" is an app that helps you cultivate luck, achieve success, and find harmony in life. 🌟

Discover 3 powerful sections designed to guide you on your journey:
1. Lucky Principles – timeless wisdom to attract positivity.
2. Daily Practices – build habits that shape your destiny.
3. Interactive Tools – personalized features to empower your path.

Start transforming your life today with 9 Gold Secrets! 💫
''';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
  icon: const FaIcon(FontAwesomeIcons.shareFromSquare, color: Colors.white),
  onPressed: () => _shareApp(context),
  tooltip: 'Share App',
);

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
