import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/TitleSection.dart';
import 'package:youvideo/ui/components/LibraryItem.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/home/tabs/home/provider.dart';
import 'package:youvideo/ui/library/library.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/ui/entity/wrap.dart';
import 'package:youvideo/ui/components/HistoryListHorizon.dart';
import 'package:youvideo/ui/video/wrap.dart';

import '../../layout.dart';

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabProvider>(
      create: (_) => HomeTabProvider(),
      child: Consumer<HomeTabProvider>(
        builder: (context, provider, child) {
          provider.loadData();
          var titleTextStyle = TextStyle(fontWeight: FontWeight.w600);

          return BaseHomeLayout(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: RefreshIndicator(
                color: Theme.of(context).colorScheme.primary,
                onRefresh: () async {
                  await provider.loadData(force: true);
                },
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Container(
                      height: 220,
                      child: VideosHorizonCollection(
                        metaHeight: 48,
                        itemHeight: 220,
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
                            ),
                          )
                        : Container(),
                    // Entities section (list-style for compactness)
                    provider.entityLoader.list.isNotEmpty
                        ? TitleSection(
                            title: "Entities",
                            titleTextStyle: titleTextStyle,
                            child: Column(
                              children: provider.entityLoader.list.take(6).map((
                                entity,
                              ) {
                                return ListTile(
                                  leading: Icon(Icons.movie_creation_outlined),
                                  title: Text(entity.displayName),
                                  onTap: () {
                                    EntityPage.Launch(context, entity.id);
                                  },
                                );
                              }).toList(),
                            ),
                          )
                        : Container(),
                    // Meta section (as tags chips)
                    provider.metaLoader.list.isNotEmpty
                        ? TitleSection(
                            title: "Meta",
                            titleTextStyle: titleTextStyle,
                            child: Wrap(
                              children: [
                                ...provider.metaLoader.list.take(12).map((
                                  meta,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                      bottom: 8,
                                    ),
                                    child: ActionChip(
                                      label: Text(meta.value ?? ""),
                                      avatar: CircleAvatar(child: Text("#")),
                                      onPressed: () {
                                        VideosPageWrap.launchWithMetaVideo(
                                          context,
                                          meta,
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )
                        : Container(),
                    // Tags section
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
                                      avatar: CircleAvatar(child: Text("#")),
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
                                                      "tag": tag.id.toString(),
                                                    },
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )
                        : Container(),
                    // History section (horizon grid)
                    provider.historyLoader.list.isNotEmpty
                        ? TitleSection(
                            title: "History",
                            titleTextStyle: titleTextStyle,
                            child: Container(
                              height: 240,
                              child: HistoryListHorizon(
                                onLoadMore: provider.historyLoader.loadMore,
                                historyList: provider.historyLoader.list,
                                onItemClick: (history) {
                                  VideoPageWrap.Launch(
                                    context,
                                    history.videoId,
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
