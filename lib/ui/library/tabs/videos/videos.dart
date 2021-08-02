import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

class LibraryVideos extends StatelessWidget {
  final LibraryProvider provider;

  LibraryVideos({this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await provider.loadVideos(force: true);
              return true;
            },
            child: VideoList(
              videos: provider.loader.list,
              onItemClick: (video) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPage(
                            videoId: video.id,
                          )),
                );
              },
              onLoadMore: () {
                if (provider.filter.random) {
                  return;
                }
                provider.loadMoreVideo();
              },
            ),
          ),
          Positioned(
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return VideoFilterView(
                        filter: provider.filter,
                        onChange: (filter) {
                          provider.filter = filter;
                          provider.loadVideos(force: true);
                        },
                      );
                    });
              },
              child: Icon(Icons.filter_list),
            ),
            bottom: 16,
            right: 16,
          )
        ],
      ),
    );
  }
}
