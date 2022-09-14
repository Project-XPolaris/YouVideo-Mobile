import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youui/components/gridview.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/util/listview.dart';

class FolderGridView extends StatelessWidget {
  final List<Folder> folders;
  final double minWidth;
  final Function()? onLoadMore;

  const FolderGridView(
      {Key? key, this.folders = const [], this.minWidth = 200, this.onLoadMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController controller = createLoadMoreController(() {
      onLoadMore?.call();
    });
    return ResponsiveGridView(
        controller: controller,
        children: folders.map((folder) {
          return Center(
            child: SizedBox(
              child: CoverTitleGridItem(
                title: folder.name,
                imageUrl: folder.cover,
                loadingCoverColor: Theme.of(context).colorScheme.primary,
                placeholderColor: Theme.of(context).colorScheme.primary,
                placeHolderIcon: Icon(Icons.folder, color: Colors.white,),
                borderRadius: 6,
                coverWidth: 120 * folder.coverRatio,
                coverHeight: 120,
                imageBoxFit: BoxFit.contain,
                onTap: (){
                  VideosPageWrap.launchWithFolderDetail(context, folder);
                },
              ),
            ),
          );
        }).toList(),
        itemWidth: 200
    );
  }
}
