import 'package:flutter/material.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/HomePage.dart';
import 'package:youvideo/ui/start/start.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Key refreshKey;

  refresh() {
    setState(() {
      refreshKey = UniqueKey();
    });
  }
  Future<bool> check() async {
    var ok = await ApplicationConfig().checkConfig();
    if (!ok) {
      return false;
    }
    ok = await ApplicationConfig().loadConfig();
    return ok;
  }
  @override
  Widget build(BuildContext context) {
    return StartPage();
  }
}
