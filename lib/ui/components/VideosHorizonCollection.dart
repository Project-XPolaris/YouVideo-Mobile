import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/components/VideoItemHorizon.dart';
import 'package:youvideo/ui/video/VideoPage.dart';


class VideosHorizonCollection extends StatelessWidget {
  final String title;
  final List<Video> videos;
  final List<CoverSize>? coverSizes;
  final TextStyle? titleStyle;
  VideosHorizonCollection(
      {this.videos = const [], this.title = "Videos", this.coverSizes,this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
      title: title,
      titleStyle: titleStyle,
      children: [
        ...videos.map((video) {
          List<CoverSize> coverSizes = this.coverSizes ?? [new CoverSize()];
          CoverSize coverSize;
          coverSize = coverSizes.firstWhereOrNull((element) => element.type == video.type) ?? new CoverSize();

          // calc max width and height
          double maxWidth = coverSizes.first.width;
          double maxHeight = coverSizes.first.height;
          coverSizes.forEach((element) {
            maxWidth = max(maxWidth, element.width);
            maxHeight = max(maxHeight,element.height);
          });
          File file = video.files.first;
          return VideoItemHorizon(
            maxCoverHeight: maxHeight,
            maxCoverWidth: maxWidth,
            coverWidth: coverSize.width,
            coverHeight: coverSize.height,
            padding: EdgeInsets.only(right: 16),
            coverUrl: file.getCoverUrl(),
            name: video.getName(),
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
          );
        })
      ],
    );
  }
}

class CoverSize {
  String type = "video";
  double width = 220;
  double height = 120;
  CoverSize({this.type = "video", this.width = 220, this.height = 120});
}
