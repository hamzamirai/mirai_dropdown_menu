/*
* Created By Mirai Devs.
* On 9/10/2023.
*/
import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({
    super.key,
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: color ?? const Color(0xFF707070).withOpacity(0.2),
    );
  }
}
