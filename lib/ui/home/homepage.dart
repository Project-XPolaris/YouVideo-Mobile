import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/appbar.dart';
import 'package:youvideo/ui/home/content.dart';

import 'provider.dart';

class HomePage extends StatelessWidget {
  final HomeProvider provider;
  HomePage({required this.provider});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderHomeAppBar(context),
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
          BottomNavigationBarItem(icon: Icon(Icons.label), label: "Tags"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "History")
        ],
      ),
      body: HomePageContent(
        provider: provider,
      ),
    );
  }
}
