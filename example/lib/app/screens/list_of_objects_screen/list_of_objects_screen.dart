/*
* Created By Mirai Devs.
* On 23/6/2022.
*/
import 'package:example/app/core/utils/app_theme.dart';
import 'package:example/app/data/projects.dart';
import 'package:example/app/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

class ListObjectsScreen extends StatefulWidget {
  const ListObjectsScreen({Key? key}) : super(key: key);

  @override
  State<ListObjectsScreen> createState() => _ListObjectsScreenState();
}

class _ListObjectsScreenState extends State<ListObjectsScreen> {
  /// ProjectModel
  final ValueNotifier<ProjectModel> projectValueNotifier =
      ValueNotifier<ProjectModel>(listProjects[0]);

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
            MiraiPopupMenu<ProjectModel>(
              key: UniqueKey(),
              children: listProjects,
              space: 4,
              itemWidget: (int index, ProjectModel project) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      _BuildContainerColor(color: project.color),
                      const SizedBox(width: 30),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${project.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            Text(
                              '${project.job}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              onChanged: (ProjectModel project) {
                projectValueNotifier.value = project;
              },
              child: Container(
                key: GlobalKey(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: const Color(0xFFECECEC),
                    width: 1.0,
                  ),
                ),
                height: 40,
                child: ValueListenableBuilder<ProjectModel>(
                    valueListenable: projectValueNotifier,
                    builder: (_, ProjectModel project, __) {
                      return Row(
                        children: [
                          _BuildContainerColor(color: project.color),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  '${project.job}',
                                  key: ValueKey('${project.title}'.trim()),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.keyTextBlackColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const FaIcon(
                            FontAwesomeIcons.chevronDown,
                            color: AppTheme.keyAppColor,
                            size: 12,
                          ),
                        ],
                      );
                    }),
              ),
              // onAction: (String value) =>
              //     timeEmployeeOrFreelancerNewEntryController.companyName.value = value,
            )
          ],
        ),
      ),
    );
  }
}

class _BuildContainerColor extends StatelessWidget {
  const _BuildContainerColor({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
