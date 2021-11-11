import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/HistoryListHorizon.dart';
import 'package:youvideo/ui/home/tabs/history/provider.dart';
import 'package:youvideo/ui/video/VideoPage.dart';

class HistoryListTabPageHorizon extends StatelessWidget {
  final HomeHistoryListProvider provider;
  HistoryListTabPageHorizon({required this.provider});
  @override
  Widget build(BuildContext context) {
    return HistoryListHorizon(onLoadMore: provider.loadMore, historyList: provider.loader.list,onItemClick: (history) {VideoPage.Launch(context, history.videoId);},);
  }
}
