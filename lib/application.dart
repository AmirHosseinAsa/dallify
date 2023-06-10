import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dallify/pages/history_page.dart';
import 'package:dallify/pages/home_page.dart';
import 'package:dallify/pages/about_page.dart';
import 'package:dallify/theme/dallify_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/about': (context) => AboutPage(),
      },
      theme: DallifyTheme.dark(),
      scrollBehavior: MyCustomScrollBehavior(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}