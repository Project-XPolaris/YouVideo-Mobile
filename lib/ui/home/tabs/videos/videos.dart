import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
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
            color: Colors.red,
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
