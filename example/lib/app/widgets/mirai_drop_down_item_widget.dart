/*
* Created By Mirai Devs.
* On 3/28/2022.
*/

import 'package:flutter/material.dart';

class MiraiDropDownItemWidget extends StatelessWidget {
  const MiraiDropDownItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      child: Text(
        item,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
