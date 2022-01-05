import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/video/wrap.dart';
import 'package:youvideo/ui/videos/wrap.dart';

class VideosHorizonCollection extends StatelessWidget {
  final String title;
  final List<Video> videos;
  final TextStyle? titleStyle;
  final double baseHeight;

  VideosHorizonCollection(
      {this.videos = const [],
      this.title = "Videos",
      required this.baseHeight,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
        children: videos.map((video) {
          var metaHeight = 24.0;
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 16),
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CoverTitleGridItem(
              placeholderColor: Colors.red,
              placeHolderIcon: Icon(Icons.videocam),
              title: video.getName(),
              metaContainerMagin: EdgeInsets.all(0),
              metaHeight: metaHeight,
              failedColor: Colors.red,
              failedIcon: Icons.videocam,
              imageUrl: video.files[0].getCoverUrl(),
              onTap: () {
                VideoPageWrap.Launch(context, video.id);
              },
            ),
          );
        }).toList(),
        title: title);
  }
}
