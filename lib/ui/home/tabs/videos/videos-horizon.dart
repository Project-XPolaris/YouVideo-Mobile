import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

import 'provider.dart';

class VideosTabPageHorizon extends StatelessWidget {
  final HomeVideosProvider provider;
  VideosTabPageHorizon({required this.provider});
  @override
  Widget build(BuildContext context) {

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
              onLoadMore: (){
                provider.loadMore();
              },
              onItemClick: (video) {
                VideoPage.Launch(context, video.id);
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
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return VideoFilterView(
                      filter: provider.filter,
                      onChange: (filter) {
                        provider.filter = filter;
                        provider.loadData(force: true);
                      },
                    );
                  });
            },
          ),
        )
      ],
    );
  }
}