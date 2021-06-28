import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/tabs/home/HomeTab.dart';
import 'package:youvideo/ui/home/tabs/hsitory/history.dart';
import 'package:youvideo/ui/home/tabs/library/library.dart';
import 'package:youvideo/ui/home/tabs/tags/tags.dart';
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
              title: Text("YouVideo",style: TextStyle(color:Colors.red),),
              backgroundColor: Color(0x1F1F1F),
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
                    icon: Icon(Icons.videocam_rounded), label: "Videos"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_library), label: "Libraries"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.label), label: "Tags"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: "History")
              ],
            ),
            body: Container(
              color: Color(0xFF121212),
              child: IndexedStack(
                index: provider.activeTab,
                children: <Widget>[
                  HomeTabPage(),
                  VideosTabPage(),
                  LibrariesTabPage(),
                  TagsTabPage(),
                  HistoryList()
                ],
              ),
            ),
          );
        }));
  }
}
