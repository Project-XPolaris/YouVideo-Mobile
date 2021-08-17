import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/info.dart';
import 'package:youvideo/api/user_auth_response.dart';
import 'package:youvideo/api/user_token.dart';
import 'package:youvideo/api/youplus_client.dart';
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

    Future<bool> _init() async {
      await LoginHistoryManager().refreshHistory();
      return true;
    }
    _onFinishClick() async {
      var uri = Uri.parse(inputUrl);
      if (!uri.hasScheme) {
        inputUrl  = "http://" + inputUrl;
      }
      if (!uri.hasPort) {
        inputUrl += ":7700";
      }

      ApplicationConfig().serviceUrl = inputUrl;
      try {
        Info info =  await ApiClient().fetchInfo();
        if (!info.success) {
          return;
        }
        bool canAccess  = false;
        if (info.name == "YouPlus service") {
          print("get entity from youplus");
          // find out entry of service
          var response  = await YouPlusClient().fetchEntityByName("youvideocore");
          for (var url in response.entity.export.urls) {
            ApplicationConfig().serviceUrl = url;
            try {
              Info info = await ApiClient().fetchInfo();
              if (info.success) {
                canAccess = true;
                break;
              }
            }on DioError catch(e) {
              continue;
            }
          }
        }else{
          canAccess = true;
        }
        if (!canAccess) {
          return;
        }
        info =  await ApiClient().fetchInfo();
        if (!info.success) {
          return;
        }
        if (info.authEnable) {
          if (inputUsername.isEmpty || inputPassword.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Service need auth")));
            return;
          }
          UserAuthResponse userAuth = await ApiClient().fetchUserAuth(inputUsername, inputPassword);
          LoginHistoryManager().add(LoginHistory(apiUrl: inputUrl, username: inputUsername, token: userAuth.token));
          ApplicationConfig().token = userAuth.token;
        }else{
          LoginHistoryManager().add(LoginHistory(apiUrl: inputUrl, username: "Public", token: ""));
        }

      } on DioError catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed: ${e.response?.data["reason"]}")));
        return;
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2b2b2b),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onFinishClick();
        },
        child: Icon(Icons.chevron_right),
      ),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          _onHistoryClick(LoginHistory history) async {
            ApplicationConfig().serviceUrl = history.apiUrl;
            try {
              Info info =  await ApiClient().fetchInfo();
              if (!info.success) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to connect host")));
                return;
              }
              if (info.authEnable) {
                if (history.token.length == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("token is empty,try to login again")));
                  return;
                }
                UserToken token = await ApiClient().userToken(history.token);
                if (!token.success){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("token is empty,try to login again")));
                  return;
                }
                ApplicationConfig().token = history.token;
              }

            } on DioError catch(e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed: ${e.response?.data["reason"]}")));
              return;
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
