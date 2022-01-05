import 'package:flutter/material.dart';
import 'package:youvideo/ui/init/init.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouVideo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        brightness: Brightness.light,
        primaryColor: Colors.red,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red
        ),
        accentColor: Colors.red,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: Index(),
    );
  }
}

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InitPage();
  }
}
