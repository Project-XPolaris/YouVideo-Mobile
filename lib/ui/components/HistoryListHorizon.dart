import 'package:flutter/material.dart';
import 'package:youui/components/cover-title-grid-item.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/util/listview.dart';

class HistoryListHorizon extends StatelessWidget {
  final Function onLoadMore;
  final List<History> historyList;
  final Function(History)? onItemClick;

  const HistoryListHorizon({
    Key? key,
    required this.onLoadMore,
    required this.historyList,
    this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(onLoadMore);
    return ListView.builder(
      controller: controller,
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: historyList.length,
      itemBuilder: (context, index) {
        final e = historyList[index];
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SizedBox(
            width: 140,
            child: CoverTitleGridItem(
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
              imageUrl: e.getCoverUrl(),
              onTap: () {
                this.onItemClick?.call(e);
              },
            ),
          ),
        );
      },
    );
  }
}
