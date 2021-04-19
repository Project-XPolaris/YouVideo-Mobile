import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/LibraryItem.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/home/tabs/home/provider.dart';
import 'package:youvideo/ui/library/library.dart';
import 'package:youvideo/ui/videos/videos.dart';

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabProvider>(
        create: (_) => HomeTabProvider(),
        child: Consumer<HomeTabProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Padding(
            padding: EdgeInsets.only(top: 32, left: 16, right: 16),
            child: RefreshIndicator(
              onRefresh: () async {
                await provider.loadData(force: true);
              },
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Container(
                    height: 240,
                    child: VideosHorizonCollection(
                      videos: provider.latestVideoLoader.list ?? [],
                      title: "Recently added",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Libraries",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ...provider.libraryLoader.list.map((library) {
                    return LibraryItem(
                      library: library,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LibraryPage(
                                    title: library.name,
                                    libraryId: library.id,
                                  )),
                        );
                      },
                    );
                  }).toList(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Tags",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Wrap(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideosPage(
                                          title: tag.name,
                                          filter: {"tag": tag.id.toString()},
                                        )),
                              );
                            },
                          ),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
