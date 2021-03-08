import 'package:flutter/material.dart';
import 'package:youvideo/ui/videos/videos.dart';

import '../../provider.dart';

class LibraryFolders extends StatelessWidget {
  final LibraryProvider provider;
  LibraryFolders({this.provider});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: provider.folderLoader.list.map((e) {
          return ListTile(
            leading: Icon(Icons.folder),
            title: Text(e.dirName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideosPage(
                      title: e.dirName,
                      filter: {"dir": e.baseDir},
                    )),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
