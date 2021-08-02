import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/components/VideoList.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/util/listview.dart';

class VideosTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeVideosProvider>(
        create: (_) => HomeVideosProvider(),
        child:
            Consumer<HomeVideosProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Stack(
            children: [
              Container(
                child: RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    await provider.loadData(force: true);
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
        }));
  }
}
