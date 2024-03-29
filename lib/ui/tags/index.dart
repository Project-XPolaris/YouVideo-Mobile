import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/tags/provider.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/util/listview.dart';

class TagsPage extends StatelessWidget {
  final String title;
  final Map<String, String> filter;

  TagsPage({this.title = "Tags", required this.filter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TagsProvider>(
        create: (_) => TagsProvider(extraFilter: filter),
        child: Consumer<TagsProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          return Scaffold(
            appBar: AppBar(
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
                  children: provider.loader.list.map((tag) {
                    return ListTile(
                        title: Text(tag.name),
                        leading: Icon(Icons.label),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VideosPageWrap(
                                      title: tag.name,
                                      filter: {"tag": tag.id.toString()},
                                    )),
                          );
                        });
                  }).toList(),
                ),
              ),
            ),
          );
        }));
  }
}
