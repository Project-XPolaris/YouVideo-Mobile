import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  Function onRefresh;
  StartPage({this.onRefresh});
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String inputUrl = "";
  @override
  Widget build(BuildContext context) {
    _apply() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("apiUrl", inputUrl);
      this.widget.onRefresh();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          _apply();
        },
        child: Icon(Icons.chevron_right),
      ),
      body: Container(
        width: double.infinity,
        color: Color(0xFF2b2b2b),
        child: Padding(
          padding: EdgeInsets.only(top: 120, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "YouVideo",
                style: TextStyle(color: Colors.white, fontSize: 42),
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
                padding: EdgeInsets.only(top: 64, left: 16, right: 16),
                child: Column(
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

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
