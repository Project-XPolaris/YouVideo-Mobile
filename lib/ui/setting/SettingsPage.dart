import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.backup_rounded),
              title: Text("Reset Api"),
              onTap: () async {
                SharedPreferences sha = await SharedPreferences.getInstance();
                sha.setString("apiUrl", null);
                final snackBar = SnackBar(
                  content: Text('apply it! try to restart',style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.black,
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
            )
          ],
        );
      }),
    );
  }
}
