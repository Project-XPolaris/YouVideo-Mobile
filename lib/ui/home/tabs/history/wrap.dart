import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/history/provider.dart';
import 'package:youvideo/ui/home/tabs/history/history.dart';
import 'package:youvideo/ui/home/tabs/history/horizon.dart';

class HistoryTabPageWrap extends StatelessWidget {
  const HistoryTabPageWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeHistoryListProvider>(
        create: (_) => HomeHistoryListProvider(),
        child:
        Consumer<HomeHistoryListProvider>(builder: (context, provider, child) {

          provider.loadData();
          return ScreenWidthSelector(verticalChild: HistoryListTabPage(provider: provider,),horizonChild: HistoryListTabPageHorizon(provider: provider,),);
        }));
  }
}
