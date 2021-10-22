import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/components/VideoItemHorizon.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

class VideosHorizonCollection extends StatelessWidget {
  final String title;
  final List<Video> videos;
  VideosHorizonCollection({this.videos = const [],this.title = "Videos"});
  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
      title: title,
      children: [
        ...videos.map((video) {
          double width = 220;
          double height = 120;
          if (video.type == 'film') {
            width = 120;
            height = 180;
          }
          File file  = video.files.first;
          return VideoItemHorizon(
            maxCoverHeight: 180,
            maxCoverWidth: 220,
            coverWidth: width,coverHeight: height,
            padding: EdgeInsets.only(right: 16),
            coverUrl: file.getCoverUrl(),
            name: video.getName(),
            onTap: () {
              var id = video.id;
              if (id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPage(videoId: id,)
                  ),
                );
              }
            },
          );
        })
      ],
    );
  }
}
