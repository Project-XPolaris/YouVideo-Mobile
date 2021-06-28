import 'package:flutter/material.dart';
import 'package:youvideo/ui/home/HomePage.dart';
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
          brightness: Brightness.light,
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
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
