import 'package:flutter/material.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/videos/provider.dart';
import 'package:youvideo/util/listview.dart';

import '../video/wrap.dart';

class VideosVerticalPage extends StatelessWidget {
  final String title;
  final Map<String,String> filter;
  final VideosProvider provider;
  VideosVerticalPage({this.title = "Videos",required this.filter,required this.provider});

  Widget build(BuildContext context) {
    var controller = createLoadMoreController(() => provider.loadMore());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x1F1F1F),
        title: Text(title),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async {
            await provider.loadData(force: true);
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
                  coverRatio: file.ratio,
                  coverUrl: file.getCoverUrl(),
                  name: video.getName(),
                  onTap: () {
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
                ),
              );
            }).toList(),
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
