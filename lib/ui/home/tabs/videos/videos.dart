import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/video/wrap.dart';

class VideosTabPage extends StatelessWidget {
  final HomeVideosProvider provider;

  VideosTabPage({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: RefreshIndicator(
            onRefresh: () async {
              await provider.loadData(force: true);
            },
            child: VideoList(
              videos: provider.loader.list,
              onItemClick: (video) {
                var id = video.id;
                if (id != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPageWrap(
                              videoId: id,
                            )),
                  );
                }
              },
              onLoadMore: () {
                if (provider.filter.random) {
                  return;
                }
                provider.loadMore();
              },
            ),
          ),
        ),
      ],
    );
  }
}
