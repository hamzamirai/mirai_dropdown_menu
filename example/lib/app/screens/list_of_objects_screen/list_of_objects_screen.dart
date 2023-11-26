/*
* Created By Mirai Devs.
* On 23/6/2022.
*/
import 'package:example/app/core/utils/app_theme.dart';
import 'package:example/app/data/projects.dart';
import 'package:example/app/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

import 'components/drop_down_object_child_widget.dart';
import 'components/drop_down_object_item_widget.dart';

class ListObjectsScreen extends StatefulWidget {
  const ListObjectsScreen({super.key});

  @override
  State<ListObjectsScreen> createState() => _ListObjectsScreenState();
}

class _ListObjectsScreenState extends State<ListObjectsScreen> {
  /// ProjectModel
  final ValueNotifier<ProjectModel> projectValueNotifierFirst =
      ValueNotifier<ProjectModel>(listProjects[0]);

  final ValueNotifier<ProjectModel> projectValueNotifierSecond =
      ValueNotifier<ProjectModel>(listProjects[1]);

  final ValueNotifier<ProjectModel> projectValueNotifierThird =
      ValueNotifier<ProjectModel>(listProjects[3]);

  final ValueNotifier<ProjectModel> projectValueNotifierFourth =
      ValueNotifier<ProjectModel>(listProjects[4]);

  final ValueNotifier<ProjectModel> projectValueNotifierFifth =
      ValueNotifier<ProjectModel>(listProjects[5]);

  final ValueNotifier<ProjectModel> projectValueNotifierSixth =
      ValueNotifier<ProjectModel>(listProjects[6]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Objects'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      backgroundColor: AppTheme.backgroundGrayColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to, \nList Of Objects screen.',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
            const SizedBox(height: 40),
            MiraiDropDownMenu<ProjectModel>(
              key: UniqueKey(),
              children: listProjects,
              space: 4,
              showSearchTextField: true,
              itemWidgetBuilder: (
                int index,
                ProjectModel? project, {
                bool isItemSelected = false,
              }) {
                return DropDownItemWidget(
                  project: project,
                  isItemSelected: isItemSelected,
                );
              },
              onChanged: (ProjectModel project) {
                projectValueNotifierFirst.value = project;
              },
              child: DropDownObjectChildWidget(
                key: GlobalKey(),
                projectValueNotifier: projectValueNotifierFirst,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 300,
                    itemWidgetBuilder: (
                      int index,
                      ProjectModel? project, {
                      bool isItemSelected = false,
                    }) {
                      return DropDownItemWidget(
                        project: project,
                        isItemSelected: isItemSelected,
                        firstSpace: 10,
                        fontSize: 12,
                      );
                    },
                    onChanged: (ProjectModel project) {
                      projectValueNotifierSecond.value = project;
                    },
                    child: DropDownObjectChildWidget(
                      key: GlobalKey(),
                      fontSize: 12,
                      projectValueNotifier: projectValueNotifierSecond,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemWidgetBuilder: (
                      int index,
                      ProjectModel? project, {
                      bool isItemSelected = false,
                    }) {
                      return DropDownItemWidget(
                        project: project,
                        isItemSelected: isItemSelected,
                        firstSpace: 10,
                        fontSize: 12,
                      );
                    },
                    onChanged: (ProjectModel project) {
                      projectValueNotifierThird.value = project;
                    },
                    child: DropDownObjectChildWidget(
                      key: GlobalKey(),
                      fontSize: 12,
                      projectValueNotifier: projectValueNotifierThird,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 300,
                    itemWidgetBuilder: (
                      int index,
                      ProjectModel? project, {
                      bool isItemSelected = false,
                    }) {
                      return DropDownItemWidget(
                        project: project,
                        isItemSelected: isItemSelected,
                        fontSize: 10,
                        firstSpace: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                      );
                    },
                    onChanged: (ProjectModel project) {
                      projectValueNotifierFourth.value = project;
                    },
                    child: DropDownObjectChildWidget(
                      key: GlobalKey(),
                      firstSpace: 6,
                      secondSpace: 6,
                      fontSize: 12,
                      coloredContainerSize: 14,
                      projectValueNotifier: projectValueNotifierFourth,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemWidgetBuilder: (
                      int index,
                      ProjectModel? project, {
                      bool isItemSelected = false,
                    }) {
                      return DropDownItemWidget(
                        project: project,
                        isItemSelected: isItemSelected,
                        fontSize: 10,
                        firstSpace: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                      );
                    },
                    onChanged: (ProjectModel project) {
                      projectValueNotifierFifth.value = project;
                    },
                    child: DropDownObjectChildWidget(
                      key: GlobalKey(),
                      firstSpace: 6,
                      secondSpace: 6,
                      fontSize: 12,
                      coloredContainerSize: 14,
                      projectValueNotifier: projectValueNotifierFifth,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemWidgetBuilder: (
                      int index,
                      ProjectModel? project, {
                      bool isItemSelected = false,
                    }) {
                      return DropDownItemWidget(
                        project: project,
                        isItemSelected: isItemSelected,
                        fontSize: 10,
                        firstSpace: 8,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                      );
                    },
                    onChanged: (ProjectModel project) {
                      projectValueNotifierSixth.value = project;
                    },
                    child: DropDownObjectChildWidget(
                      key: GlobalKey(),
                      firstSpace: 6,
                      secondSpace: 6,
                      fontSize: 12,
                      coloredContainerSize: 14,
                      projectValueNotifier: projectValueNotifierSixth,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
