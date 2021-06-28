import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/history.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2b2b2b),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _apply();
        },
        child: Icon(Icons.chevron_right),
      ),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          _onHistoryClick(LoginHistory history) async {
            var config = ApplicationConfig();
            config.token = history.token;
            config.serviceUrl = history.apiUrl;
            var info = await ApiClient().fetchInfo();
            if (info.authEnable && config.token.isNotEmpty) {
              Dio dio = new Dio();
              try {
                var response = await dio.get(info.authUrl,
                    queryParameters: {"token": config.token});
              } on DioError catch (err) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "User auth failed:${err.response.data["reason"]}",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black,
                ));
                return;
              }

            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }

          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              color: Color(0xFF2b2b2b),
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "YouVideo",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 42,
                      ),
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
                    Expanded(
                        child: DefaultTabController(
                      length: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 240,
                            margin: EdgeInsets.only(
                              top: 16,
                              bottom: 16,
                            ),
                            child: TabBar(
                              tabs: [
                                Tab(
                                  text: "History",
                                ),
                                Tab(
                                  text: "New login",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(children: [
                            Container(
                              child: ListView(
                                children:
                                    LoginHistoryManager().list.map((history) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      onTap: () => _onHistoryClick(history),
                                      leading: CircleAvatar(
                                        child: Icon(Icons.person),
                                      ),
                                      title: Text(history.username),
                                      subtitle: Text(history.apiUrl),
                                      tileColor: Colors.black26,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Service url',
                                    ),
                                    cursorColor: Colors.red,
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
                                      cursorColor: Colors.red,
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
                                      cursorColor: Colors.red,
                                      obscureText: true,
                                      onChanged: (text) {
                                        setState(() {
                                          inputPassword = text;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]))
                        ],
                      ),
                    )),
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
