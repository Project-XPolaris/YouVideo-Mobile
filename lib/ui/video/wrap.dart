import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/video/horizon.dart';

import 'provider.dart';

class VideoPageWrap extends StatelessWidget {
  final int videoId;

  const VideoPageWrap({Key? key, required this.videoId}) : super(key: key);

  static Launch(BuildContext context, int? id) {
    if (id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                VideoPageWrap(
                  videoId: id,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoProvider>(
        create: (_) => VideoProvider(videoId: videoId),
        child: Consumer<VideoProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ScreenWidthSelector(
            verticalChild: VideoPageVertical(provider: provider,),
            horizonChild: VideoHorizonPage(provider: provider,),
          );
        }));
  }
}
