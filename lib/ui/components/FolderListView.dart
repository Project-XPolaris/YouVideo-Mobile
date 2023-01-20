import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-list-item.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/util/listview.dart';

class FolderListView extends StatelessWidget {
  final List<Folder> folders;
  final Function()? onLoadMore;

  const FolderListView({Key? key, this.folders = const [], this.onLoadMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = createLoadMoreController(() {
      onLoadMore?.call();
    });
    return ListView(
      controller: controller,
      children: [
        ...folders.map((folder) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            alignment: Alignment.topRight,
            child: CoverTitleListItem(
              title: folder.name,
              metaContainerMagin: EdgeInsets.only(left: 16),
              imageUrl: folder.cover,
              loadingCoverColor: Theme.of(context).colorScheme.primary,
              placeholderColor: Theme.of(context).colorScheme.primary,
              coverHeight: 120 * folder.coverHeightRatio,
              coverWidth: 120,
              borderRadius: 6,
              imageBoxFit: BoxFit.contain,
              onTap: () {
                VideosPageWrap.launchWithFolderDetail(context, folder);
              },
            ),
          );
        })
      ],
    );
  }
}
