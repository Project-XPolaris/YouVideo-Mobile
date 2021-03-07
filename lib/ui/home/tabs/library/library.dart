import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/LibraryItem.dart';
import 'package:youvideo/ui/home/tabs/library/provider.dart';
import 'package:youvideo/ui/videos/videos.dart';
import 'package:youvideo/util/listview.dart';

class LibrariesTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeLibrariesProvider>(
        create: (_) => HomeLibrariesProvider(),
        child: Consumer<HomeLibrariesProvider>(
            builder: (context, provider, child) {
          var controller = createLoadMoreController(() => provider.loadMore());
          provider.loadData();
          return Container(
            child: RefreshIndicator(
              onRefresh: () async {
                provider.loader.firstLoad = true;
                await provider.loader.loadData();
                return true;
              },
              child: ListView(
                controller: controller,
                physics: AlwaysScrollableScrollPhysics(),
                children: provider.loader.list.map((library) {
                  return LibraryItem(
                    library: library,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideosPage(
                                  title: library.name,
                                  filter: {"library": library.id.toString()},
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
