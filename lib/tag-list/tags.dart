import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/tag-list/provider.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/util/listview.dart';

class TagListPage extends StatelessWidget {
  static launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TagListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TagListProvider>(
        create: (_) => TagListProvider(),
        child: Consumer<TagListProvider>(builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          return Scaffold(
              appBar: AppBar(
                title: Text("Tags"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Container(
                child: RefreshIndicator(
                  color: Theme.of(context).colorScheme.primary,
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
                        },
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Wrap(children: [
                                  ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text("Delete tag"),
                                    onTap: () {
                                      var id = tag.id;
                                      if (id != null) {
                                        provider.removeTag(id);
                                      }
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Container(
                                    height: 16,
                                  )
                                ]);
                              });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ));
        }));
  }
}
