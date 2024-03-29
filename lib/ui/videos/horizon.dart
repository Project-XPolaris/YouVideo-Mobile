import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoListHorizon.dart';
import 'package:youvideo/ui/video/wrap.dart';
import 'package:youvideo/ui/videos/provider.dart';

class VideosHorizonPage extends StatelessWidget {
  final String title;
  final Map<String, String> filter;
  final VideosProvider provider;

  VideosHorizonPage(
      {this.title = "Videos", required this.filter, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x1F1F1F),
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
