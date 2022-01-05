import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/entity/horizon.dart';
import 'package:youvideo/ui/home/tabs/entity/provider.dart';

class HomeEntityWrap extends StatelessWidget {
  const HomeEntityWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeEntityProvider>(
        create: (_) => HomeEntityProvider(),
        child:
            Consumer<HomeEntityProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ScreenWidthSelector(
            verticalChild: HomeEntityHorizonView(
              provider: provider,
            ),
            horizonChild: HomeEntityHorizonView(
              provider: provider,
            ),
          );
        }));
  }
}
