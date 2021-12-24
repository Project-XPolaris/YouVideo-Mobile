import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/navigation.dart';
import 'package:youui/layout/home/home.dart';
import 'package:youvideo/ui/home/appbar.dart';
import 'package:youvideo/ui/home/content.dart';
import 'package:youvideo/ui/home/provider.dart';
import 'package:youvideo/ui/search/index.dart';

class HomePageWrap extends StatelessWidget {
  const HomePageWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return ResponsiveTabPageLayout(
            onTabIndexChange: provider.setActiveTab,
            tabIndex: provider.activeTab,
            navItems: [
              NavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              NavigationBarItem(icon: Icon(Icons.videocam), label: "Videos"),
              NavigationBarItem(icon: Icon(Icons.video_library), label: "Libraries"),
              NavigationBarItem(icon: Icon(Icons.label), label: "Tags"),
              NavigationBarItem(icon: Icon(Icons.history), label: "History")
            ],
            appbar: renderHomeAppBar(context),
            navigationStyle: NavigationStyle(
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.white54,
              backgroundColor: Color(0x1F1F1F),
            ),
            body: HomePageContent(provider: provider,),
            action: Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SearchPage()),);
                  }, icon: Icon(Icons.search))
                ],
              ),
            ),
          );
        }));
  }
}
