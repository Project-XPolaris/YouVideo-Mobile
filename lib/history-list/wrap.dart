import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/history-list/horizon.dart';
import 'package:youvideo/history-list/vertical.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';

import 'provider.dart';


class HistoryListPageWrap extends StatelessWidget {
  const HistoryListPageWrap({Key? key}) : super(key: key);
  static launch(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HistoryListPageWrap()));
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryListProvider>(
        create: (_) => HistoryListProvider(),
        child: Consumer<HistoryListProvider>(
            builder: (context, provider, child) {
          provider.loadData();
          return Scaffold(
            appBar: AppBar(
              title: Text("History"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
              body: ScreenWidthSelector(
            verticalChild: HistoryListVerticalPage(
              provider: provider,
            ),
            horizonChild: HistoryListTabPageHorizon(
              provider: provider,
            ),
          ));
        }));
  }
}
