import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

class VideosHorizonCollection extends StatelessWidget {
  final String title;
  final List<Video> videos;
  final List<CoverSize>? coverSizes;
  final TextStyle? titleStyle;

  VideosHorizonCollection(
      {this.videos = const [],
      this.title = "Videos",
      this.coverSizes,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
        children: videos.map((video) {
          double containerWidth = 280;
          if (video.type == "film") {
            containerWidth = 120;
          }
          return Container(
            margin: EdgeInsets.only(right: 16),
            width: containerWidth,
            height: containerWidth,
            child: CoverTitleGridItem(
              imageBoxFit: BoxFit.fitHeight,
              title: video.getName(),
              metaContainerMagin: EdgeInsets.all(0),
              coverWidth: containerWidth,
              coverHeight: 120 - 64,
              metaHeight: 64,
              imageUrl: video.files[0].getCoverUrl(),
              onTap: () {
                var id = video.id;
                if (id != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPage(
                          videoId: id,
                        )),
                  );
                }
              },
            ),
          );
        }).toList(),
        title: "Recently add");
  }
}

class CoverSize {
  String type = "video";
  double width = 220;
  double height = 120;
  CoverSize({this.type = "video", this.width = 220, this.height = 120});
}
