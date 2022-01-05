import 'package:flutter/material.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/ui/components/VideoItem.dart';
import 'package:youvideo/util/listview.dart';

class HistoryList extends StatelessWidget {
  final Function onLoadMore;
  final Function(History)? onItemClick;
  final List<History> historyList;

  const HistoryList(
      {Key? key,
      this.onItemClick,
      required this.onLoadMore,
      this.historyList = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = createLoadMoreController(onLoadMore);
    return ListView(
      controller: controller,
      physics: AlwaysScrollableScrollPhysics(),
      children: historyList.map((history) {
        return Padding(
          padding: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
          child: VideoItem(
            coverUrl: history.getCoverUrl(),
            name: history.name,
            onTap: () {
              this.onItemClick?.call(history);
            },
          ),
        );
      }).toList(),
    );
  }
}
