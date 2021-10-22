import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoCover.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/util/listview.dart';

class VideoList extends StatefulWidget {
  final Function onLoadMore;
  final Function(Video)? onItemClick;
  final List<Video> videos;

  const VideoList({Key? key, this.onItemClick, required this.onLoadMore, this.videos = const []})
      : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(widget.onLoadMore);
    // var media = MediaQuery.of(context);
    // return GridView.count(
    //   controller: controller,
    //   crossAxisCount: (media.size.width / 150).toInt(),
    //   crossAxisSpacing: 8,
    //   mainAxisSpacing: 8,
    //   children: widget.videos.map((video) {
    //     File file = video.files.first;
    //     return Stack(
    //       children: [
    //         Positioned(child:  VideoCover(
    //           coverUrl: file.getCoverUrl(),
    //         ),bottom: 0,)
    //        ,
    //         Positioned(child: Container(
    //           color: Colors.black54,
    //           width: 140,
    //           child: Text(video.name,maxLines: 2,),
    //         ),bottom: 0, )
    //
    //       ],
    //     );
    //   }).toList(),
    // );
    return ListView(
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
      children: widget.videos.map((video) {
        File file = video.files.first;
        return Padding(
          padding: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
          child: VideoItem(
            coverUrl: file.getCoverUrl(),
            name: video.getName(),
            onTap: () {
              var handler = this.widget.onItemClick;
              if (handler != null) {
                handler(video);
              }
            },
            type: video.type
          ),
        );
      }).toList(),
    );
  }
}
