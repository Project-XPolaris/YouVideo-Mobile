import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoCover.dart';
import 'package:youvideo/util/listview.dart';

class VideoListHorizon extends StatelessWidget {
  final Function onLoadMore;
  final List<Video> videos;
  final Function(Video)? onItemClick;
  final bool directoryView;

  const VideoListHorizon(
      {Key? key,
      required this.onLoadMore,
      required this.videos,
      this.onItemClick,
      this.directoryView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var crossAxisCount = width ~/ 200;
    var controller = createLoadMoreController(onLoadMore);
    return GridView.count(
      controller: controller,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: crossAxisCount,
      children: <Widget>[
        ...videos.map((e) {
          File file = e.files.first;
          String name = directoryView ? e.getDirname() : e.getName();
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: VideoCover(
                  coverUrl: file.getCoverUrl(),
                  onTap: () {
                    onItemClick?.call(e);
                  },
                  borderRadius: 8,
                )),
                Container(
                  child: Text(
                    name,
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                  ),
                  height: 64,
                )
              ],
            ),
          );
        }),
      ],
    );
  }
}
