import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:material_ui/material_ui.dart';

class const AdaptiveDialogButton({super.key, required final void Function() onPressed, required final Widget child}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => switch (context.theme.platform) {
    .iOS || .macOS => CupertinoDialogAction(onPressed: onPressed, child: child),
    _ => TextButton(onPressed: onPressed, child: child),
  };
}
