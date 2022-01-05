import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/video/wrap.dart';

import 'provider.dart';

class VideosTabPageHorizon extends StatelessWidget {
  final HomeVideosProvider provider;

  VideosTabPageHorizon({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      endDrawer: Drawer(
        child: VideoFilterView(
          filter: provider.filter,
          onChange: (filter) {
            provider.filter = filter;
            provider.loadData(force: true);
          },
        ),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: [
            Container(
              child: RefreshIndicator(
                color: Colors.red,
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
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                child: Icon(Icons.filter_list),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();

                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (ctx) {
                  //       return VideoFilterView(
                  //         filter: provider.filter,
                  //         onChange: (filter) {
                  //           provider.filter = filter;
                  //           provider.loadData(force: true);
                  //         },
                  //       );
                  //     });
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
