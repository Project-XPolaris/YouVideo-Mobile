import 'package:flutter/material.dart';
import 'package:youui/components/gridview.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoItemHorizon.dart';
import 'package:youvideo/util/listview.dart';

class VideoListHorizon extends StatelessWidget {
  final Function onLoadMore;
  final List<Video> videos;
  final Function(Video)? onItemClick;
  final bool directoryView;
  final int itemWidth;

  const VideoListHorizon(
      {Key? key,
      required this.onLoadMore,
      required this.videos,
      this.onItemClick,
      this.itemWidth = 180,
      this.directoryView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(onLoadMore);
    return ResponsiveGridView(
        controller: controller,
        children: videos.map((video) {
          return VideoItemHorizon(
            name: video.getName(),
            coverUrl: video.files.first.getCoverUrl(),
            onTap: () {
              onItemClick?.call(video);
            },
          );
        }).toList(),
        itemWidth: itemWidth);
  }
}
