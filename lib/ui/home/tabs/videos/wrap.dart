import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';
import 'package:youvideo/ui/home/tabs/videos/videos-horizon.dart';
import 'package:youvideo/ui/home/tabs/videos/videos.dart';

import '../../../components/GridViewModeMenu.dart';
import '../../../components/VideoFilter.dart';
import '../../layout.dart';

class VideosTabPageWrap extends StatelessWidget {
  const VideosTabPageWrap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return ChangeNotifierProvider<HomeVideosProvider>(
        create: (_) => HomeVideosProvider(),
        child:
            Consumer<HomeVideosProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Scaffold(
            endDrawer: Drawer(
              child: VideoFilterView(
                filter: provider.filter,
                onChange: (filter) {
                  provider.filter = filter;
                  provider.loadData(force: true);
                },
              ),
            ),
            body: Builder(builder: (context) {
              return BaseHomeLayout(
                child: Scaffold(
                  key: _scaffoldKey,
                  body: ScreenWidthSelector(
                    verticalChild: VideosTabPage(provider: provider),
                    horizonChild: VideosTabPageHorizon(provider: provider),
                  ),
                ),
                extra: [
                  Container(
                    margin: EdgeInsets.only(top: 32),
                  ),
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(Icons.filter_list_rounded)),
                  Container(
                      margin: EdgeInsets.only(top: 8),
                      child: GirdViewModeMenu(
                        onModeChange: (String gridViewMode) {
                          provider.updateGridViewType(gridViewMode);
                        },
                      )),
                ],
              );
            }),
          );
        }));
  }
}
