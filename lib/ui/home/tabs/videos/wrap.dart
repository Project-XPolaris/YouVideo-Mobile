import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/home/tabs/videos/provider.dart';

import '../../../components/GridViewModeMenu.dart';
import '../../../components/LayoutViewModeMenu.dart';
import '../../../components/VideoFilter.dart';
import '../../../components/VideoList.dart';
import '../../../components/VideoListHorizon.dart';
import '../../../video/wrap.dart';
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
                  body: Container(
                    child: RefreshIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      onRefresh: () async {
                        await provider.loadData(force: true);
                      },
                      child: ScreenWidthSelector(
                        forceLayout: provider.layoutType,
                        verticalChild: Container(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await provider.loadData(force: true);
                            },
                            child: VideoList(
                              videos: provider.loader.list,
                              onItemClick: (video) {
                                var id = video.id;
                                if (id != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPageWrap(
                                              videoId: id,
                                            )),
                                  );
                                }
                              },
                              onLoadMore: () {
                                if (provider.filter.random) {
                                  return;
                                }
                                provider.loadMore();
                              },
                            ),
                          ),
                        ),
                        horizonChild: VideoListHorizon(
                          videos: provider.loader.list,
                          onLoadMore: () {
                            provider.loadMore();
                          },
                          onItemClick: (video) {
                            VideoPageWrap.Launch(context, video.id);
                          },
                          itemWidth: provider.gridItemWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                extra: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(Icons.filter_list_rounded)),
                  Container(child: GirdViewModeMenu(
                    onModeChange: (String gridViewMode) {
                      provider.updateGridViewType(gridViewMode);
                    },
                  )),
                  Container(child: LayoutViewModeMenu(
                    onModeChange: (String mode) {
                      provider.updateLayoutType(mode);
                    },
                  )),
                ],
              );
            }),
          );
        }));
  }
}
