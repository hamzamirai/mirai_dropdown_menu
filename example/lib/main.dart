import 'package:example/app/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/core/utils/app_size_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return OrientationBuilder(builder: (context, orientation) {
        /// init sizes
        AppSizeConfig.init(
          orientation: orientation,
          constraints: boxConstraints,
        );
        return MaterialApp(
          title: 'Mirai dropdown menu example',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Colors.transparent,
            textTheme: TextTheme(
              headline1: GoogleFonts.nunito(),
              button: GoogleFonts.nunito(),
            ),
          ),
          home: const HomeScreen(title: 'Mirai Dropdown menu \nExample'),
        );
      });
    });
  }
}
