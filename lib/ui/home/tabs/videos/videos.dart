import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/video-item.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
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
                return VideoItem(
                  coverUrl: video.getCoverUrl(),
                  name: video.name,
                  onTap: () {
                    final AndroidIntent intent = AndroidIntent(
                      action: 'action_view',
                      data: video.getStreamUrl(),
                      type: "video/*",
                      arguments: <String, dynamic>{},
                    );
                    intent.launch();
                  },
                );
              }).toList(),
            ),
          );
        }));
  }
}
