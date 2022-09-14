import 'package:flutter/material.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/start/start.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Key? refreshKey;

  refresh() {
    setState(() {
      refreshKey = UniqueKey();
    });
  }

  Future<bool> check() async {
    await ApplicationConfig().loadConfig();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: check(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {

              return StartPage();

          }
          return Container();
        });
  }
}
