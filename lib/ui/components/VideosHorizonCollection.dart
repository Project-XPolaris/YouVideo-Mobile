import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/HorizonCollection.dart';
import 'package:youvideo/ui/video/wrap.dart';

class VideosHorizonCollection extends StatelessWidget {
  final String title;
  final List<Video> videos;
  final TextStyle? titleStyle;
  final double metaHeight;
  final double itemHeight;
  final Function(Video)? onTap;
  final Function(Video)? onTitleTap;

  VideosHorizonCollection(
      {this.videos = const [],
      this.title = "Videos",
      this.metaHeight = 48.0,
      this.itemHeight = 180,
      this.onTap,
      this.onTitleTap,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return HorizonCollection(
        children: videos.map((video) {
          var width = (itemHeight - metaHeight) * video.files[0].ratio;
          return Container(
            margin: EdgeInsets.only(right: 16),
            width: width,
            height: itemHeight,
            child: CoverTitleGridItem(
              coverWidth: width,
              placeholderColor:
                  Theme.of(context).colorScheme.secondaryContainer,
              placeHolderIcon: Icon(Icons.videocam_rounded),
              title: video.getName(),
              metaContainerMagin: EdgeInsets.all(0),
              metaHeight: metaHeight,
              failedColor: Theme.of(context).colorScheme.secondaryContainer,
              failedIcon: Icons.videocam,
              imageUrl: video.files[0].getCoverUrl(),
              onTap: () {
                if (onTap == null) {
                  VideoPageWrap.Launch(context, video.id);
                } else {
                  onTap!(video);
                }
              },
              onTitleTap: () {
                if (onTitleTap == null) {
                  VideoPageWrap.Launch(context, video.id);
                } else {
                  onTitleTap!(video);
                }
              },
              titleMaxLine: 2,
              borderRadius: 8,
            ),
          );
        }).toList(),
        title: title);
  }
}
