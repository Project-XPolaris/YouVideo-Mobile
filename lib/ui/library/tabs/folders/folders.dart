import 'package:flutter/material.dart';
import 'package:youvideo/ui/videos/videos.dart';
import 'package:youvideo/util/listview.dart';

import '../../provider.dart';

class LibraryFolders extends StatelessWidget {
  final LibraryProvider provider;
  LibraryFolders({required this.provider});
  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(() => provider.loadMoreFolders());
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await provider.loadDirectory(force: true);
        },
        child: ListView(
          controller: controller,
          physics: AlwaysScrollableScrollPhysics(),
          children: provider.folderLoader.list.map((e) {
            return ListTile(
              leading: Icon(Icons.folder),
              title: Text(e.dirName ?? ""),
              onTap: () {
                var baseDir = e.baseDir;
                if (baseDir != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideosPage(
                          title: e.dirName ?? "",
                          filter: {"dir": baseDir},
                        )),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
