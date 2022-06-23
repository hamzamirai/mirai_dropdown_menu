/*
* Created By Mirai Devs.
* On 23/6/2022.
*/
import 'package:flutter/material.dart';

class ListObjectsScreen extends StatelessWidget {
  const ListObjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Objects'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
    );
  }
}
