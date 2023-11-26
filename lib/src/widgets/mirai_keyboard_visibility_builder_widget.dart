import 'package:flutter/material.dart';

/*
* Created By Mirai Devs.
* On 3/28/2022.
*/

class MiraiKeyboardVisibilityBuilder extends StatefulWidget {
  final Widget? child;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  const MiraiKeyboardVisibilityBuilder({
    super.key,
    this.child,
    required this.builder,
  });

  @override
  MiraiKeyboardVisibilityBuilderState createState() =>
      MiraiKeyboardVisibilityBuilderState();
}

class MiraiKeyboardVisibilityBuilderState
    extends State<MiraiKeyboardVisibilityBuilder> with WidgetsBindingObserver {
  bool _isKeyboardVisible =
      WidgetsBinding.instance.window.viewInsets.bottom > 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final bool newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.child,
        _isKeyboardVisible,
      );
}
