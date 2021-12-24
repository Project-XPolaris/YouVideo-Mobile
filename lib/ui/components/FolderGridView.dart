import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youui/components/gridview.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/ui/videos/videos.dart';
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
          getWidth() {
            if (folder.type == "video") {
              return 200.0;
            }
            if (folder.type == "film") {
              return 100.0;
            }
          }
          return Center(
            child: SizedBox(
              child: CoverTitleGridItem(
                title: folder.name,
                imageUrl: folder.cover,
                titleTextStyle: TextStyle(color: Colors.white),
                loadingCoverColor: Colors.black26,
                placeholderColor: Colors.red,
                placeHolderIcon: Icon(Icons.folder, color: Colors.white,),
                borderRadius: 6,
                coverWidth: getWidth(),
                imageBoxFit: BoxFit.contain,
                onTap: (){
                  VideosPage.launchWithFolderDetail(context, folder);
                },
              ),
            ),
          );
        }).toList(),
        itemWidth: 200
    );
  }
}
