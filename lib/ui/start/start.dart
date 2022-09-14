import 'package:flutter/material.dart';
import 'package:youui/layout/login/LoginLayout.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/wrap.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoginLayout(
        onLoginSuccess: (loginAccount) {
          ApplicationConfig().serviceUrl = loginAccount.apiUrl;
          ApplicationConfig().token = loginAccount.token;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePageWrap()));
        },
        title: "YouVideo",
        subtitle: "ProjectXPolaris",
      ),
    );
  }
}
