import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/homepage-horizon.dart';
import 'package:youvideo/ui/home/homepage.dart';
import 'package:youvideo/ui/home/provider.dart';

class HomePageWrap extends StatelessWidget {
  const HomePageWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: Consumer<HomeProvider>(builder: (context, provider, child) {
          return ScreenWidthSelector(
            verticalChild: HomePage(provider: provider),
            horizonChild: HomePageHorizon(
              provider: provider,
            ),
          );
        }));
  }
}
