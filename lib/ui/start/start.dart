import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youplusauthplugin/youplusauthplugin.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/info.dart';
import 'package:youvideo/api/user_auth_response.dart';
import 'package:youvideo/api/user_token.dart';
import 'package:youvideo/api/youplus_client.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/home/wrap.dart';
import 'package:youvideo/util/login_history.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Youplusauthplugin plugin = new Youplusauthplugin();
  String inputUrl = "";
  String inputUsername = "";
  String inputPassword = "";
  String loginMode = "history";
  String authUsername = "";
  String authToken = "";

  @override
  Widget build(BuildContext context) {
    bool _applyUrl() {
      if (inputUrl.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("please input service url")));
        return false;
      }
      var uri;
      try {
        uri = Uri.parse(inputUrl);
      } on FormatException catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("input service url invalidate")));
        return false;
      }
      if (!uri.hasScheme) {
        inputUrl = "http://" + inputUrl;
      }
      if (!uri.hasPort) {
        inputUrl += ":7700";
      }
      ApplicationConfig().serviceUrl = inputUrl;
      return true;
    }

    _onAuthComplete(String username, String token) async {
      try {
        Info info = await ApiClient().fetchInfo();
        if (!info.success) {
          return;
        }
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login failed: ${e.response?.data["reason"]}")));
        return;
      }
      ApplicationConfig().token = token;
      LoginHistoryManager().add(LoginHistory(
          apiUrl: ApplicationConfig().serviceUrl,
          username: username,
          token: token));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageWrap()));
    }

    Future<bool> _init() async {
      await LoginHistoryManager().refreshHistory();
      plugin.registerAuthCallback((username, token) {
        _onAuthComplete(username, token);
      });
      return true;
    }

    _onFinishClick() async {
      if (!_applyUrl()) {
        return;
      }
      print(ApplicationConfig().serviceUrl);
      try {
        Info info = await ApiClient().fetchInfo();
        if (!info.success) {
          return;
        }
        bool canAccess = false;
        if (info.name == "YouPlus service") {
          // find out entry of service
          var response =
              await YouPlusClient().fetchEntityByName("youvideocore");
          print(response);
          for (var url in response.entity!.export!.urls) {
            ApplicationConfig().serviceUrl = url;
            try {
              Info info = await ApiClient().fetchInfo();
              if (info.success) {
                canAccess = true;
                break;
              }
            } on DioError catch (_) {
              continue;
            }
          }
        } else {
          canAccess = true;
        }
        if (!canAccess) {
          return;
        }
        info = await ApiClient().fetchInfo();
        if (!info.success) {
          return;
        }
        if (info.authEnable!) {
          if (inputUsername.isEmpty || inputPassword.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Service need auth")));
            return;
          }
          UserAuthResponse userAuth =
              await ApiClient().fetchUserAuth(inputUsername, inputPassword);
          LoginHistoryManager().add(LoginHistory(
              apiUrl: ApplicationConfig().serviceUrl,
              username: inputUsername,
              token: userAuth.token));
          ApplicationConfig().token = userAuth.token;
        } else {
          LoginHistoryManager().add(LoginHistory(
              apiUrl: ApplicationConfig().serviceUrl,
              username: "Public",
              token: ""));
        }
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Login failed: ${e.response?.data["reason"]}")));
        return;
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageWrap()));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2b2b2b),
      ),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          _onHistoryClick(LoginHistory history) async {
            ApplicationConfig().serviceUrl = history.apiUrl;
            try {
              Info info = await ApiClient().fetchInfo();
              if (!info.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to connect host")));
                return;
              }
              if (info.authEnable!) {
                if (history.token!.length == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("token is empty,try to login again")));
                  return;
                }
                UserToken token = await ApiClient().userToken(history.token!);
                if (!token.success!) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("token is empty,try to login again")));
                  return;
                }
                ApplicationConfig().token = history.token;
              }
            } on DioError catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("Login failed: ${e.response?.data["reason"]}")));
              return;
            }
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePageWrap()));
          }

          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              color: Color(0xFF2b2b2b),
              child: Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
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
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                        child: DefaultTabController(
                          initialIndex: LoginHistoryManager().list.isEmpty ? 1: 0,
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
                              child: TabBarView(
                            children: [
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
                                        title: Text(history.username!),
                                        subtitle: Text(history.apiUrl!),
                                        tileColor: Colors.black26,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                child: ListView(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white24,
                                              width: 1.0),
                                        ),
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
                                        decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white24,
                                                  width: 1.0),
                                            ),
                                            hintText: 'Username'),
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
                                        decoration: new InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white24,
                                                width: 1.0),
                                          ),
                                          hintText: 'Password',
                                        ),
                                        cursorColor: Colors.red,
                                        obscureText: true,
                                        onChanged: (text) {
                                          setState(() {
                                            inputPassword = text;
                                          });
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(top: 16),
                                      child: ElevatedButton(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(),
                                        ),
                                        onPressed: () {
                                          _onFinishClick();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: TextButton(
                                        child: Text(
                                          "Login with YouPlus",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          if (!_applyUrl()) {
                                            return;
                                          }
                                          plugin.openYouPlus();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
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
