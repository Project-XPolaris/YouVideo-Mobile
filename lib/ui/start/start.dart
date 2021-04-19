import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/HomePage.dart';
import 'package:youvideo/util/login_history.dart';

class StartPage extends StatefulWidget {
  Function onRefresh;

  StartPage({this.onRefresh});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";

  @override
  Widget build(BuildContext context) {
    _apply() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("apiUrl", inputUrl);
      await ApplicationConfig().loadConfig();
      var info = await ApiClient().fetchInfo();
      if (inputUsername.isEmpty && inputPassword.isEmpty) {
        // without login
        ApplicationConfig().token = "";
        LoginHistoryManager()
            .add(LoginHistory(apiUrl: inputUrl, username: "public", token: ""));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return;
      }
      // login with account
      Dio dio = new Dio();
      var response = await dio.post(info.authUrl, data: {
        "username": inputUsername,
        "password": inputPassword,
      });
      if (response.data["success"]) {
        ApplicationConfig().token = response.data["token"];
        LoginHistoryManager().add(LoginHistory(
            apiUrl: inputUrl,
            username: inputUsername,
            token: response.data["token"]));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      // this.widget.onRefresh();
    }

    Future<bool> _init() async {
      await LoginHistoryManager().refreshHistory();
      return true;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apply();
        },
        child: Icon(Icons.chevron_right),
      ),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              color: Color(0xFF2b2b2b),
              child: Padding(
                padding: EdgeInsets.only(top: 64, left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "YouVideo",
                      style: TextStyle(color: Colors.white70, fontSize: 42),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "ProjectXPolaris",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  loginMode = "history";
                                });
                              },
                              child: Text(
                                "LoginHistory",
                                style: TextStyle(
                                    color: loginMode == "history"
                                        ? Colors.white
                                        : Colors.white54,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  loginMode = "new";
                                });
                              },
                              child: Text(
                                "New Login",
                                style: TextStyle(
                                  color: loginMode == "new"
                                      ? Colors.white
                                      : Colors.white54,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w300,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                      ),
                      child: loginMode == "new"
                          ? Column(
                              children: [
                                TextField(
                                  decoration:
                                      InputDecoration(hintText: 'Service url'),
                                  onChanged: (text) {
                                    setState(() {
                                      inputUrl = text;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: TextField(
                                    decoration:
                                        InputDecoration(hintText: 'Username'),
                                    onChanged: (text) {
                                      setState(() {
                                        inputUsername = text;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: TextField(
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    onChanged: (text) {
                                      setState(() {
                                        inputPassword = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : ListView(
                              children:
                                  LoginHistoryManager().list.map((history) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  color: Colors.black26,
                                  child: ListTile(
                                    onTap: () {
                                      var config = ApplicationConfig();
                                      config.token = history.token;
                                      config.serviceUrl = history.apiUrl;
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => HomePage()));
                                    },
                                    leading: CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(history.username),
                                    subtitle: Text(history.apiUrl),
                                    tileColor: Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                    ))
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
