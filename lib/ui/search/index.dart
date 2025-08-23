import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/search/provider.dart';
import 'package:youvideo/ui/tags/index.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/ui/library/library.dart';
import 'package:youvideo/ui/entity/wrap.dart';

import '../video/wrap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget _buildSearchBar(BuildContext context, SearchProvider provider) {
    return Container(
      height: 48,
      width: double.infinity,
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
                onChanged: (text) {
                  provider.setSearchKey(text);
                },
              ),
            ),
            flex: 1,
          ),
          Container(
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.search),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                provider.search();
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
    );
  }

  String _displayCount(int count) {
    if (count > 99) return "99+";
    return count.toString();
  }

  Widget _tabLabel(BuildContext context, String title, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            _displayCount(count),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (context, provider, child) {
          final videosCount = provider.searchResult?.videos.length ?? 0;
          final entitiesCount = provider.searchResult?.entities.length ?? 0;
          final librariesCount = provider.libraries.length;
          final tagsCount = provider.tagLoader.list.length;
          final metasCount = provider.metas.length;

          final hasVideos = videosCount > 0;
          final hasEntities = entitiesCount > 0;
          final hasLibraries = librariesCount > 0;
          final hasTags = tagsCount > 0;
          final hasMetas = metasCount > 0;

          final List<Tab> tabs = [];
          final List<Widget> tabViews = [];

          if (hasVideos) {
            tabs.add(Tab(child: _tabLabel(context, "Videos", videosCount)));
            tabViews.add(
              ListView(
                children: [
                  ...provider.searchResult!.videos.map((video) {
                    String? coverUrl;
                    if (video.files.isNotEmpty) {
                      var first = video.files[0];
                      coverUrl = first.getCoverUrl();
                    }
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: VideoItem(
                        coverRatio: video.files[0].ratio,
                        coverUrl: coverUrl,
                        name: video.getName(),
                        onTap: () {
                          var id = video.id;
                          if (id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoPageWrap(videoId: id),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        var key = provider.searchKey;
                        if (key != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideosPageWrap(
                                filter: {"search": key},
                                title:
                                    "Search result for ${provider.searchKey}",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text("more"),
                    ),
                  ),
                ],
              ),
            );
          }

          if (hasEntities) {
            tabs.add(Tab(child: _tabLabel(context, "Entities", entitiesCount)));
            tabViews.add(
              ListView(
                children: [
                  ...provider.searchResult!.entities.map((entity) {
                    return ListTile(
                      leading: Icon(Icons.movie_creation_outlined),
                      title: Text(entity.displayName),
                      subtitle: Text(entity.displaySummary),
                      onTap: () {
                        EntityPage.Launch(context, entity.id);
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          }

          if (hasLibraries) {
            tabs.add(
              Tab(child: _tabLabel(context, "Libraries", librariesCount)),
            );
            tabViews.add(
              ListView(
                children: [
                  ...provider.libraries.map((library) {
                    return ListTile(
                      leading: Icon(Icons.video_library_outlined),
                      title: Text(library.getName()),
                      onTap: () {
                        LibraryPage.Launch(context, library);
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          }

          if (hasTags) {
            tabs.add(Tab(child: _tabLabel(context, "Tags", tagsCount)));
            tabViews.add(
              ListView(
                children: [
                  ...provider.tagLoader.list.map((tag) {
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
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        var key = provider.searchKey;
                        if (key != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TagsPage(
                                filter: {"search": key},
                                title:
                                    "Search result for ${provider.searchKey}",
                              ),
                            ),
                          );
                        }
                      },
                      child: Text("more"),
                    ),
                  ),
                ],
              ),
            );
          }

          if (hasMetas) {
            tabs.add(Tab(child: _tabLabel(context, "Metas", metasCount)));
            tabViews.add(
              ListView(
                children: [
                  ...provider.metas.map((meta) {
                    return ListTile(
                      leading: Icon(Icons.tag),
                      title: Text(meta.value ?? ""),
                      subtitle: Text(meta.key ?? ""),
                      onTap: () {
                        VideosPageWrap.launchWithMetaVideo(context, meta);
                      },
                    );
                  }).toList(),
                ],
              ),
            );
          }

          Widget buildScaffold({PreferredSizeWidget? bottom}) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: _buildSearchBar(context, provider),
                bottom: bottom,
              ),
              body: Container(
                child: provider.isSearching
                    ? Center(
                        child: Container(
                          width: 120,
                          child: LinearProgressIndicator(),
                        ),
                      )
                    : (tabs.isEmpty
                          ? Container(
                              child: (Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.texture, size: 72),
                                    Text(
                                      "no result",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              )),
                            )
                          : TabBarView(children: tabViews)),
              ),
            );
          }

          if (tabs.isEmpty) {
            return buildScaffold();
          }

          return DefaultTabController(
            length: tabs.length,
            child: buildScaffold(
              bottom: TabBar(
                isScrollable: true,
                padding: EdgeInsets.only(left: 16),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                dividerColor: Colors.transparent,
                tabs: tabs,
                labelPadding: EdgeInsets.only(right: 8, top: 6, bottom: 6),
              ),
            ),
          );
        },
      ),
    );
  }
}
