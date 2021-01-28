import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/util/listview.dart';

class VideosTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeVideosProvider>(
        create: (_) => HomeVideosProvider(),
        child:
            Consumer<HomeVideosProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          print(provider.loader.list);
          return Container(
            child: ListView(
              controller: controller,
              children: provider.loader.list.map((video) {
                File file = video.files.first;
                return VideoItem(
                  coverUrl: file.getCoverUrl(),
                  name: video.name,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPage(
                                videoId: video.id,
                              )),
                    );
                  },
                );
              }).toList(),
            ),
          );
        }));
  }
}
