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
  VideosHorizonCollection({this.videos,this.title = "Videos"});
  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
      title: title,
      children: [
        ...videos.map((video) {
          File file  = video.files.first;
          return VideoItemHorizon(
            coverWidth: 220,coverHeight: 120,
            padding: EdgeInsets.only(right: 16),
            coverUrl: file.getCoverUrl(),
            name: video.name,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPage(videoId: video.id,)
                ),
              );
            },
          );
        })
      ],
    );
  }
}
