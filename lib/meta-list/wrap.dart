import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/meta-list/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';

import 'horizon.dart';

class MetaListWrap extends StatelessWidget {
  const MetaListWrap({Key? key}) : super(key: key);

  static launch(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MetaListWrap()));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeMetaProvider>(
        create: (_) => HomeMetaProvider(),
        child: Consumer<HomeMetaProvider>(builder: (context, provider, child) {
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
