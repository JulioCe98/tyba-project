import 'package:flutter/material.dart';

import 'package:tyba_hiring_test/src/app/screens/history/search_history_screen.dart';
import 'package:tyba_hiring_test/src/app/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tyba Hiring test',
        initialRoute: HomeScreen.routeName,
        routes: {HomeScreen.routeName: (context) => const HomeScreen(), SearchHistoryScreen.routeName: (context) => const SearchHistoryScreen()});
  }
}
