import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/videos/provider.dart';
import 'package:youvideo/util/listview.dart';

class VideosPage extends StatelessWidget {
  final String title;
  final Map<String,String> filter;
  VideosPage({this.title = "Videos",this.filter});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideosProvider>(
        create: (_) => VideosProvider(extraFilter: filter),
        child:
        Consumer<VideosProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          print(provider.loader.list);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0x1F1F1F),
              title: Text(title),
            ),
            body: Container(
              color: Color(0xFF121212),
              child: RefreshIndicator(
                onRefresh: () async {
                  await provider.loadData(force: true);
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
            ),
          );
        }));
  }
}
