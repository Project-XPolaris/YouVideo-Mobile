import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/video/wrap.dart';

import 'provider.dart';

class VideosTabPageHorizon extends StatelessWidget {
  final HomeVideosProvider provider;

  VideosTabPageHorizon({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Stack(
          children: [
            Container(
              child: RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                onRefresh: () async {
                  await provider.loadData(force: true);
                },
                child: VideoListHorizon(
                  videos: provider.loader.list,
                  onLoadMore: () {
                    provider.loadMore();
                  },
                  onItemClick: (video) {
                    VideoPageWrap.Launch(context, video.id);
                  },
                  itemWidth: provider.gridItemWidth,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
