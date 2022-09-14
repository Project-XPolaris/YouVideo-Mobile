import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/FolderGridView.dart';
import 'package:youvideo/ui/components/FolderListView.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/library/provider.dart';

import '../../layout.dart';

class DirectoryListView extends StatelessWidget {
  final LibraryProvider provider;

  const DirectoryListView({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidthSelector(
      verticalChild: FolderListView(
        folders: provider.folderLoader.list,
      ),
      horizonChild: FolderGridView(
        folders: provider.folderLoader.list,
        onLoadMore: provider.loadMoreFolders,
      ),
    );
  }
}
