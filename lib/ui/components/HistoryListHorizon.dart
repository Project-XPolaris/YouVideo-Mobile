import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/ui/components/VideoCover.dart';
import 'package:youvideo/util/listview.dart';

class HistoryListHorizon extends StatelessWidget {
  final Function onLoadMore;
  final List<History> historyList;
  final Function(History)? onItemClick;
  const HistoryListHorizon({Key? key,required this.onLoadMore,required this.historyList,this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var crossAxisCount = width ~/ 200;
    var controller = createLoadMoreController(onLoadMore);
    return GridView.count(
      controller: controller,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: AlwaysScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      children: <Widget>[
        ...historyList.map((e) {
          return CoverTitleGridItem(
              borderRadius: 4,
              metaHeight: 32,
              metaContainerMagin: EdgeInsets.only(),
              title: e.name,
              imageBoxFit: BoxFit.contain,
              placeHolderIcon: Icon(
                Icons.videocam,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 48,
              ),
              placeholderColor: Theme.of(context).colorScheme.primaryContainer,
              imageUrl:e.getCoverUrl(),
              onTap: () {
                this.onItemClick?.call(e);
              });
        })
        ,
      ],
    );
  }
}
