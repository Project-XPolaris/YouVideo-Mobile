import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/library/tabs/entities/list-wrap.dart';

import 'provider.dart';
import 'tabs/folders/folders.dart';
import 'tabs/videos/videos.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    switch (provider.index) {
      case 1:
        return LibraryVideos();
      case 2:
        return LibraryFolders(
          provider: provider,
        );
      case 0:
        return EntityListView();
    }
    return Container();
  }
}
