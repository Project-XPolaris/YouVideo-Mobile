import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:youvideo/ui/home/appbar.dart';
import 'package:youvideo/ui/home/content.dart';
import 'package:youvideo/ui/home/provider.dart';
import 'package:youvideo/ui/search/index.dart';

class HomePageHorizon extends StatelessWidget {
  final HomeProvider provider;

  const HomePageHorizon({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                    child: Container(
                  child: NavigationRail(
                    selectedIconTheme: IconThemeData(
                      color: Colors.red,
                    ),
                    unselectedIconTheme: IconThemeData(color: Colors.white54),
                    backgroundColor: Color(0x1F1F1F),
                    destinations: [
                      NavigationRailDestination(
                          icon: Icon(Icons.home), label: Text("Home")
                      ),
                      NavigationRailDestination(
                          icon: Icon(Icons.videocam_rounded),
                          label: Text("Videos")),
                      NavigationRailDestination(
                          icon: Icon(Icons.video_library),
                          label: Text("Libraries")),
                      NavigationRailDestination(
                          icon: Icon(Icons.label), label: Text("Tags")),
                      NavigationRailDestination(
                          icon: Icon(Icons.history), label: Text("History"))
                    ],
                    selectedIndex: provider.activeTab,
                    onDestinationSelected: (index) {
                      provider.setActiveTab(index);
                    },
                  ),
                )),
                Container(
                  padding: EdgeInsets.only(bottom: 16,top: 16),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.search,color: Colors.white,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              child: Scaffold(
                body: HomePageContent(
                  provider: provider,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
