import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/meta/provider.dart';

import 'horizon.dart';

class HomeMetaWrap extends StatelessWidget {
  const HomeMetaWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeMetaProvider>(
        create: (_) => HomeMetaProvider(),
        child:
        Consumer<HomeMetaProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ScreenWidthSelector(
            verticalChild: HomeMetaHorizonView(
              provider: provider,
            ),
            horizonChild: HomeMetaHorizonView(
              provider: provider,
            ),
          );
        }));
  }
}
