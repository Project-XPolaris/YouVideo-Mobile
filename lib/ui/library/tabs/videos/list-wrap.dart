import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

class VideoListView extends StatelessWidget {
  final LibraryProvider provider;
  const VideoListView({Key? key,required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidthSelector(
        verticalChild: VideoList(
      videos: provider.loader.list,
      onItemClick: (video) {
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
      onLoadMore: () {
        if (provider.filter.random) {
          return;
        }
        provider.loadMoreVideo();
      },
    ),
      horizonChild: VideoListHorizon(
        videos: provider.loader.list,
        onLoadMore: provider.loadMoreVideo,
        onItemClick: (video) {
          VideoPage.Launch(context, video.id);
        },
      ),
    );
  }
}
