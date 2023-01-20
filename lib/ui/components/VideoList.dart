import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/util/listview.dart';

class VideoList extends StatefulWidget {
  final Function onLoadMore;
  final Function(Video)? onItemClick;
  final List<Video> videos;
  final bool directoryView;

  const VideoList(
      {Key? key,
      this.onItemClick,
      required this.onLoadMore,
      this.videos = const [],
      this.directoryView = false})
      : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(widget.onLoadMore);
    return ListView(
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
      children: widget.videos.map((video) {
        File file = video.files.first;
        return Padding(
          padding: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
          child: VideoItem(
            coverUrl: file.getCoverUrl(),
            name: widget.directoryView ? video.getDirname() : video.getName(),
            coverRatio: file.ratio,
            onTap: () {
              var handler = this.widget.onItemClick;
              if (handler != null) {
                handler(video);
              }
            },
          ),
        );
      }).toList(),
    );
  }
}
