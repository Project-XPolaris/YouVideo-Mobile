import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/home/tabs/home/provider.dart';

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabProvider>(
        create: (_) => HomeTabProvider(),
        child: Consumer<HomeTabProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Padding(
            padding: EdgeInsets.only(top: 32, left: 16, right: 16),
            child: RefreshIndicator(
              onRefresh: () async{
                await provider.loadData(force: true);
              },
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  VideosHorizonCollection(videos:provider.latestVideoLoader.list ?? [])
                ],
              ),
            ),
          );
        }));
  }
}
