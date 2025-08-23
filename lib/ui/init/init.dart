import 'package:flutter/material.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/wrap.dart';
import 'package:youvideo/ui/start/start.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);
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
    final hasUrl = (ApplicationConfig().serviceUrl ?? "").isNotEmpty;
    final hasToken = (ApplicationConfig().token ?? "").isNotEmpty;
    return hasUrl && hasToken;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: check(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final goHome = snapshot.data == true;
        if (goHome) {
          return HomePageWrap();
        }
        return const StartPage();
      },
    );
  }
}
