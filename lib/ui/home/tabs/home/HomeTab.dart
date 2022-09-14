import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/TitleSection.dart';
import 'package:youvideo/ui/components/LibraryItem.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/home/tabs/home/provider.dart';
import 'package:youvideo/ui/library/library.dart';
import 'package:youvideo/ui/videos/wrap.dart';

import '../../layout.dart';

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabProvider>(
        create: (_) => HomeTabProvider(),
        child: Consumer<HomeTabProvider>(builder: (context, provider, child) {
          provider.loadData();
          var titleTextStyle =
          TextStyle(fontWeight: FontWeight.w600);

          return BaseHomeLayout(
            child: Padding(
              padding: EdgeInsets.only(top: 32, left: 16, right: 16),
              child: RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                onRefresh: () async {
                  await provider.loadData(force: true);
                },
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 235,
                      child: VideosHorizonCollection(
                        baseHeight: 160,
                        videos: provider.latestVideoLoader.list,
                        title: "Recently added",
                      ),
                    ),
                    provider.libraryLoader.list.isNotEmpty
                        ? TitleSection(
                        title: "Libraries",
                        child: Container(
                          child: Column(
                            children: [
                              ...provider.libraryLoader.list.map((library) {
                                return LibraryItem(
                                  library: library,
                                  onTap: () {
                                    LibraryPage.Launch(context, library);
                                  },
                                );
                              }).toList(),
                            ],
                          ),
                        ))
                        : Container(),
                    provider.tagLoader.list.isNotEmpty
                        ? TitleSection(
                      title: "Tags",
                      titleTextStyle: titleTextStyle,
                      child: Wrap(
                        children: [
                          ...provider.tagLoader.list.map((tag) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                label: Text(tag.name),
                                avatar: CircleAvatar(
                                  child: Text("#"),
                                ),
                                onPressed: () {
                                  var id = tag.id;
                                  if (id != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideosPageWrap(
                                                title: tag.name,
                                                filter: {
                                                  "tag": tag.id.toString()
                                                },
                                              )),
                                    );
                                  }
                                },
                              ),
                            );
                          })
                        ],
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
