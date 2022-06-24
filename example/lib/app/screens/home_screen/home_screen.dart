/*
* Created By Mirai Devs.
* On 23/6/2022.
*/

import 'package:example/app/screens/list_of_objects_screen/list_of_objects_screen.dart';
import 'package:example/app/screens/list_of_strings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to, \nMirai Drop Down Menu.',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
              const SizedBox(height: 40),
              Text(
                'MiraiDevs developed the Mirai Dropdown Menu Package. Using this package, you can set a static list of objects or a list you have downloaded from an API.',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListOfStringScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  'List of Texts/Strings',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListObjectsScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  'List of Objects',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
