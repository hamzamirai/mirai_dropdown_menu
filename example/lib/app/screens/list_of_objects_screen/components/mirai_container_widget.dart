/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:flutter/material.dart';

class MiraiContainerWidget extends StatelessWidget {
  const MiraiContainerWidget({
    Key? key,
    required this.color,
    this.size,
  }) : super(key: key);

  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 20,
      width: size ?? 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
