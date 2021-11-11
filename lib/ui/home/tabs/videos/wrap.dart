import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/home/tabs/videos/videos-horizon.dart';
import 'package:youvideo/ui/home/tabs/videos/videos.dart';

class VideosTabPageWrap extends StatelessWidget {
  const VideosTabPageWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeVideosProvider>(
        create: (_) => HomeVideosProvider(),
        child:
            Consumer<HomeVideosProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ScreenWidthSelector(
            verticalChild: VideosTabPage(provider: provider),
            horizonChild: VideosTabPageHorizon(provider: provider),
          );
        }));
  }
}
