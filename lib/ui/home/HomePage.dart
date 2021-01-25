import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/tabs/home/HomeTab.dart';
import 'package:youvideo/ui/home/tabs/videos/videos.dart';

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
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (idx) {
                provider.setActiveTab(idx);
              },
              currentIndex: provider.activeTab,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white54,
              backgroundColor: Colors.black,
              elevation: 0,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.videocam_rounded), label: "Video")
              ],
            ),
            body: Center(
              child: IndexedStack(
                index: provider.activeTab,
                children: <Widget>[
                  HomeTabPage(),
                  VideosTabPage()
                ],
              ),
            ),
          );
        }));
  }
}
