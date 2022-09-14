import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/ui/search/provider.dart';
import 'package:youvideo/ui/tags/index.dart';
import 'package:youvideo/ui/videos/wrap.dart';

import '../video/wrap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(),
        child: Consumer<SearchProvider>(builder: (context, provider, child) {
          List<Widget> renderResultList() {
            List<Widget> widgets = [];
            if (provider.videoLoader.list.isNotEmpty) {
              widgets.add(Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Videos result",
                      style: TextStyle(),
                    ),
                  )),
                  TextButton(
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
                                    )),
                          );
                        }
                      },
                      child: Text(
                        "more",
                        style: TextStyle(),
                      ))
                ],
              ));
              provider.videoLoader.list.forEach((video) {
                String? coverUrl;
                if (video.files.isNotEmpty) {
                  var first = video.files[0];
                  coverUrl = first.getCoverUrl();
                }
                widgets.add(Container(
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
                              builder: (context) => VideoPageWrap(
                                    videoId: id,
                                  )),
                        );
                      }
                    },
                  ),
                ));
              });
            }
            if (provider.tagLoader.list.isNotEmpty) {
              widgets.add(Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Tags result",
                      style: TextStyle(),
                    ),
                  )),
                  TextButton(
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
                                    )),
                          );
                        }
                      },
                      child: Text(
                        "more",
                        style: TextStyle(),
                      ))
                ],
              ));
              provider.tagLoader.list.forEach((tag) {
                widgets.add(ListTile(
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
                    }));
              });
            }
            return widgets;
          }

          Widget renderResult() {
            if (provider.tagLoader.list.isEmpty &&
                provider.videoLoader.list.isEmpty) {
              return Container(
                child: (Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.texture,
                        size: 72,
                      ),
                      Text(
                        "no result",
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                )),
              );
            }
            return ListView(
              children: [...renderResultList()],
            );
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Container(
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
                          style: TextStyle(
                            fontSize: 16,
                          ),
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
                        icon: Icon(
                          Icons.search,
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          provider.search();
                        },
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(32))),
              ),
            ),
            body: Container(
              child: provider.isSearching
                  ? Center(
                      child: Container(
                        width: 120,
                        child: LinearProgressIndicator(
                        ),
                      ),
                    )
                  : renderResult(),
            ),
          );
        }));
  }
}
