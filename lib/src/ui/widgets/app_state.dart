import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App Lifecycle: Running -> onIncactive (App list) -> onHide -> onPause -> onRestart -> onShow -> onResume
mixin _AppLifecycleMixin<T extends StatefulWidget> on State<T> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();

    _lifecycleListener = AppLifecycleListener(
      onResume: onResume,
      onInactive: onInactive,
      onHide: onHide,
      onShow: onShow,
      onPause: onPause,
      onRestart: onRestart,
      onDetach: onDetach,
      onStateChange: onStateChange,
      onExitRequested: onExitRequested,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => onUIReady());
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  void onUIReady() {}

  void onResume() {}

  void onInactive() {}

  void onHide() {}

  void onShow() {}

  void onPause() {}

  void onRestart() {}

  void onDetach() {}

  void onStateChange(AppLifecycleState state) {}

  Future<AppExitResponse> onExitRequested() {
    return Future.value(AppExitResponse.exit);
  }
}

abstract class AppState<T extends StatefulWidget> extends State<T>
    with _AppLifecycleMixin<T>;

abstract class AppConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T>
    with _AppLifecycleMixin<T>;
