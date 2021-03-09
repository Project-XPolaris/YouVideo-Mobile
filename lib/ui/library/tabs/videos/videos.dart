import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/util/listview.dart';

class LibraryVideos extends StatelessWidget {
  final LibraryProvider provider;

  LibraryVideos({this.provider});

  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(() => provider.loadMoreVideo());
    return Container(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await provider.loadVideos(force: true);
              return true;
            },
            child: ListView(
              controller: controller,
              physics: AlwaysScrollableScrollPhysics(),
              children: provider.loader.list.map((video) {
                File file = video.files.first;
                return Padding(
                  padding:
                      EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
                  child: VideoItem(
                    coverUrl: file.getCoverUrl(),
                    name: video.name,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPage(
                                  videoId: video.id,
                                )),
                      );
                    },
                  ),
                );
              }).toList(),
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
            bottom: 16,right: 16,
          )
        ],
      ),
    );
  }
}
