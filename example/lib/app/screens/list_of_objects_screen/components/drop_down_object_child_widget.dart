/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:example/app/core/utils/app_theme.dart';
import 'package:example/app/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'mirai_container_widget.dart';

class DropDownObjectChildWidget extends StatelessWidget {
  const DropDownObjectChildWidget({
    Key? key,
    required this.projectValueNotifier,
    this.firstSpace = 12,
    this.secondSpace = 16,
    this.padding,
    this.fontSize,
    this.coloredContainerSize,
    this.height,
  }) : super(key: key);

  final ValueNotifier<ProjectModel> projectValueNotifier;
  final double firstSpace;
  final double secondSpace;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? coloredContainerSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: GlobalKey(),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: const Color(0xFFECECEC),
          width: 1.0,
        ),
      ),
      height: height ?? 40,
      child: ValueListenableBuilder<ProjectModel>(
        valueListenable: projectValueNotifier,
        builder: (_, ProjectModel project, __) {
          return Row(
            children: <Widget>[
              MiraiContainerWidget(
                color: project.color,
                size: coloredContainerSize,
              ),
              SizedBox(width: firstSpace),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      '${project.job}',
                      key: ValueKey<String>('${project.title}'.trim()),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.keyTextBlackColor,
                            fontSize: fontSize,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: secondSpace),
              const FaIcon(
                FontAwesomeIcons.chevronDown,
                color: AppTheme.keyAppColor,
                size: 12,
              ),
            ],
          );
        },
      ),
    );
  }
}
