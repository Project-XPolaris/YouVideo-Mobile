import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/tabs/tags/provider.dart';
import 'package:youvideo/ui/videos/videos.dart';
import 'package:youvideo/util/listview.dart';

class TagsTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTagsProvider>(
        create: (_) => HomeTagsProvider(),
        child:
        Consumer<HomeTagsProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          return Container(
            child: RefreshIndicator(
              onRefresh: () async {
                await provider.loader.loadData(force: true);
                return true;
              },
              child: ListView(
                controller: controller,
                physics: AlwaysScrollableScrollPhysics(),
                children: provider.loader.list.map((tag) {
                  return ListTile(
                    title: Text(tag.name),
                    leading: Icon(Icons.label),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideosPage(
                              title: tag.name,
                              filter: {"tag": tag.id.toString()},
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }));
  }
}