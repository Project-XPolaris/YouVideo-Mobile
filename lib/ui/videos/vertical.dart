import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/videos/provider.dart';
import 'package:youvideo/util/listview.dart';

import '../video/wrap.dart';

class VideosVerticalPage extends StatelessWidget {
  final String title;
  final Map<String, String> filter;
  final VideosProvider provider;

  VideosVerticalPage(
      {this.title = "Videos", required this.filter, required this.provider});

  Widget build(BuildContext context) {
    var controller = createLoadMoreController(() => provider.loadMore());
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            await provider.loadData(force: true);
          },
          child: VideoList(
            videos: provider.loader.list,
            onLoadMore: () {
              controller.loadMore();
            },
            onItemClick: (video) {
              VideoPageWrap.Launch(context, video.id);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.filter_list),
      ),
    );
  }
}
