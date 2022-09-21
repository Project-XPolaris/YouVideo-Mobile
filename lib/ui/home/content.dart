import 'package:flutter/material.dart';
import 'package:youvideo/ui/home/provider.dart';
import 'package:youvideo/ui/home/tabs/category/wrap.dart';
import 'package:youvideo/ui/home/tabs/home/HomeTab.dart';
import 'package:youvideo/ui/home/tabs/library/library.dart';
import 'package:youvideo/ui/home/tabs/my/wrap.dart';
import 'package:youvideo/ui/home/tabs/videos/wrap.dart';

class HomePageContent extends StatelessWidget {
  final HomeProvider provider;
  const HomePageContent({Key? key,required this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexedStack(
        index: provider.activeTab,
        children: <Widget>[
          HomeTabPage(),
          VideosTabPageWrap(),
          LibrariesTabPage(),
          HomeCategoryWrap(),
          HomeMyWrap(),
        ],
      ),
    );
  }
}
