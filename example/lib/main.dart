import 'package:example/app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/core/utils/app_size_config.dart';

void main() {
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  if (isProduction) {
    // analyser does not like empty function body
    // debugPrint = (String message, {int wrapWidth}) {};
    // so i changed it to this:
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        return OrientationBuilder(
          builder: (__, Orientation orientation) {
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
          },
        );
      },
    );
  }
}
