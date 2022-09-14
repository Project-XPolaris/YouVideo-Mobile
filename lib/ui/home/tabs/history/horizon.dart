import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/HistoryListHorizon.dart';
import 'package:youvideo/ui/home/tabs/history/provider.dart';
import 'package:youvideo/ui/video/wrap.dart';

class HistoryListTabPageHorizon extends StatelessWidget {
  final HomeHistoryListProvider provider;

  HistoryListTabPageHorizon({required this.provider});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          await provider.loadData(force: true);
        },
        child: HistoryListHorizon(
          onLoadMore: provider.loadMore,
          historyList: provider.loader.list,
          onItemClick: (history) {
            VideoPageWrap.Launch(context, history.videoId);
          },
        ));
  }
}
