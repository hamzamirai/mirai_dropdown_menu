/*
* Created By Mirai Devs.
* On 23/6/2022.
* Updated with Modern Portfolio Design & Localization
*/
import 'package:example/app/core/localization/app_language_keys.dart';
import 'package:example/app/core/localization/state/language_notifier.dart';
import 'package:example/app/core/localization/views/language_picker.dart';
import 'package:example/app/core/theme/app_theme.dart';
import 'package:example/app/core/utils/app_extension.dart';
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
    final String currentLangCode =
        LanguageNotifier.instance.currentLocale.languageCode;
    final String currentFlag =
        languageData[currentLangCode]?['flag'] ?? '🌐';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppLanguagesKeys.objectDropdownsTitleKey)),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () => ChangeLanguage.showSheet(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      currentFlag,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text(
            context.tr(AppLanguagesKeys.objectDropdownsHeaderKey),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBlueColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr(AppLanguagesKeys.objectDropdownsSubtitleKey),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          // Section 1: Full Width Dropdown with Search
          _buildSectionHeader('Full Width with Search'),
          const SizedBox(height: 12),
          _buildDropdownCard(
            child: MiraiDropDownMenu<ProjectModel>(
              key: UniqueKey(),
              children: listProjects,
              space: 4,
              showSearchTextField: true,
              itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemPadding: EdgeInsets.zero,
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
          ),
          
          const SizedBox(height: 40),
          
          // Section 2: Two Column Layout
          _buildSectionHeader('Two Column Layout'),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 300,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemPadding: EdgeInsets.zero,
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
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemPadding: EdgeInsets.zero,
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
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Section 3: Three Column Layout
          _buildSectionHeader('Three Column Layout'),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 300,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemPadding: EdgeInsets.zero,
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
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemPadding: EdgeInsets.zero,
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
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropDownMenu<ProjectModel>(
                    key: UniqueKey(),
                    children: listProjects,
                    space: 4,
                    maxHeight: 360,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    itemPadding: EdgeInsets.zero,
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
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDropdownCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
