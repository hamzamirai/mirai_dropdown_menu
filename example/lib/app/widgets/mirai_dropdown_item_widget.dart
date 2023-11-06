/*
* Created By Mirai Devs.
* On 3/28/2022.
*/

import 'package:example/app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

class MiraiDropDownItemWidget extends StatelessWidget {
  const MiraiDropDownItemWidget({
    Key? key,
    required this.item,
    this.showHighLight = false,
    this.query,
  }) : super(key: key);

  final String? item;
  final bool showHighLight;
  final String? query;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 16.0,
        ),
        child: showHighLight
            ? SubstringHighlight(
                text: '$item',
                term: query,
                textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppTheme.keyDarkBlueColor.withOpacity(.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                textStyleHighlight:
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: AppTheme.keyDarkBlueColor,
                          overflow: TextOverflow.ellipsis,
                        ),
              )
            : Text(
                '$item',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
