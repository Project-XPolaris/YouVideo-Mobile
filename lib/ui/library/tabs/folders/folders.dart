import 'package:flutter/material.dart';
import 'package:youvideo/ui/library/tabs/folders/list-wrap.dart';

import '../../provider.dart';

class LibraryFolders extends StatelessWidget {
  final LibraryProvider provider;

  LibraryFolders({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
          await provider.loadDirectory(force: true);
        },
        child: DirectoryListView(
          provider: provider,
        ),
      ),
    );
  }
}
