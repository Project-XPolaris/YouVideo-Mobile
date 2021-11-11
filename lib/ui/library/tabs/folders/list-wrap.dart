import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/videos/videos.dart';

class DirectoryListView extends StatelessWidget {
  final LibraryProvider provider;

  const DirectoryListView({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidthSelector(
      verticalChild: VideoList(
        videos: provider.folderLoader.list,
        directoryView: true,
        onItemClick: (video) {
          VideosPage.launchWithFolderDetail(context, video);
        },
        onLoadMore: provider.loadMoreFolders,
      ),
      horizonChild: VideoListHorizon(
        videos: provider.folderLoader.list,
        directoryView: true,
        onLoadMore: provider.loadMoreFolders,
        onItemClick: (video) {
          VideosPage.launchWithFolderDetail(context, video);
        },
      ),
    );
  }
}
