import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/navigation.dart';
import 'package:youui/layout/home/home.dart';
import 'package:youvideo/ui/home/appbar.dart';
import 'package:youvideo/ui/home/provider.dart';
import 'package:youvideo/ui/search/index.dart';

class BaseHomeLayout extends StatelessWidget {
  final Widget? child;
  final List<Widget> extra;

  const BaseHomeLayout({Key? key, this.child, this.extra = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return ResponsiveTabPageLayout(
      onTabIndexChange: provider.setActiveTab,
      tabIndex: provider.activeTab,
      navItems: [
        NavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        NavigationBarItem(icon: Icon(Icons.videocam_rounded), label: "Videos"),
        NavigationBarItem(
            icon: Icon(Icons.video_library_rounded), label: "Libraries"),
        NavigationBarItem(
            icon: Icon(Icons.category_rounded), label: "Category"),
        NavigationBarItem(icon: Icon(Icons.person_rounded), label: "My"),
      ],
      appbar: renderHomeAppBar(context, actions: this.extra),
      body: child,
      action: Expanded(
        child: Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Expanded(
                child: Container(child: Column(children: extra)),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    );
                  },
                  icon: Icon(Icons.search_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
