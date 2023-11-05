/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:example/app/models/project_model.dart';
import 'package:flutter/material.dart';

import 'mirai_container_widget.dart';

class DropDownItemWidget extends StatelessWidget {
  const DropDownItemWidget({
    Key? key,
    required this.project,
    this.firstSpace = 30,
    this.padding,
    this.fontSize,
  }) : super(key: key);

  final ProjectModel? project;
  final double firstSpace;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    if (project == null) return const SizedBox.shrink();
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),
      child: Row(
        children: <Widget>[
          MiraiContainerWidget(color: project!.color),
          SizedBox(width: firstSpace),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${project!.name}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    color: Colors.black,
                    fontSize: fontSize,
                  ),
                ),
                Text(
                  '${project!.job}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                    color: Colors.grey.shade600,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
