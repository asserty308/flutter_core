import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

class AdaptiveDialogButton extends StatelessWidget {
  const AdaptiveDialogButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => switch (context.theme.platform) {
    TargetPlatform.iOS || TargetPlatform.macOS => CupertinoDialogAction(
      onPressed: onPressed,
      child: child,
    ),
    _ => TextButton(onPressed: onPressed, child: child),
  };
}
