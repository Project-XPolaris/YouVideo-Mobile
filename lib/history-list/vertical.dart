import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/HistoryList.dart';
import 'package:youvideo/ui/video/wrap.dart';

import 'provider.dart';

class HistoryListVerticalPage extends StatelessWidget {
  final HistoryListProvider provider;

  HistoryListVerticalPage({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: RefreshIndicator(
            color: Theme.of(context).colorScheme.primary,
            onRefresh: () async {
              provider.loadData(force: true);
            },
            child: HistoryList(
              onLoadMore: () {
                provider.loadMore();
              },
              historyList: provider.loader.list,
              onItemClick: (history) {
                VideoPageWrap.Launch(context, history.videoId);
              },
            ),
          ),
        ),
      ],
    );
  }
}
