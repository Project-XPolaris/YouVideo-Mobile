import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/tabs/home/HomeTab.dart';
import 'package:youvideo/ui/home/tabs/library/library.dart';
import 'package:youvideo/ui/home/tabs/videos/videos.dart';
import 'package:youvideo/ui/setting/SettingsPage.dart';

import 'provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("YouVideo"),
              backgroundColor: Color(0x1F1F1F),
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Text("YouVideo",style: TextStyle(fontSize: 28),),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (idx) {
                provider.setActiveTab(idx);
              },
              currentIndex: provider.activeTab,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white54,
              backgroundColor: Color(0x1F1F1F),
              elevation: 0,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.videocam_rounded), label: "Video"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_library), label: "Library")
              ],
            ),
            body: Container(
              color: Color(0xFF121212),
              child: IndexedStack(
                index: provider.activeTab,
                children: <Widget>[HomeTabPage(), VideosTabPage(),LibrariesTabPage()],
              ),
            ),
          );
        }));
  }
}
