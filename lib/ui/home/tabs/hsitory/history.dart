import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/home/tabs/hsitory/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/util/listview.dart';

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeHistoryListProvider>(
        create: (_) => HomeHistoryListProvider(),
        child:
        Consumer<HomeHistoryListProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          return Stack(
            children: [
              Container(
                child: RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    await provider.loadData(force: true);
                  },
                  child: ListView(
                    controller: controller,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: provider.loader.list.map((history) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: 4, left: 4, top: 8, bottom: 8),
                        child: VideoItem(
                          coverUrl: history.getCoverUrl(),
                          name: history.name,
                          onTap: () {
                            var id = history.videoId;
                            if (id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPage(
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
            ],
          );
        }));
  }
}
