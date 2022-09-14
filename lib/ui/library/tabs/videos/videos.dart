import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/library/tabs/videos/list-wrap.dart';

import '../../layout.dart';

class LibraryVideos extends StatelessWidget {

  LibraryVideos();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    return Scaffold(
      endDrawer:MediaQuery.of(context).size.width > 600? Drawer(
        child: VideoFilterView(
          filter: provider.filter,
          onChange: (filter) {
            provider.filter = filter;
            provider.loadVideos(force: true);
          },
        ),
      ):null,
      body: Builder(builder: (context) {
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                await provider.loadVideos(force: true);
              },
              child: VideoListView(),
            ),
            Positioned(
              child: FloatingActionButton(
                onPressed: () {
                  if (MediaQuery.of(context).size.width > 600) {
                    Scaffold.of(context).openEndDrawer();
                    return;
                  }
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return VideoFilterView(
                          filter: provider.filter,
                          onChange: (filter) {
                            provider.filter = filter;
                            provider.loadVideos(force: true);
                          },
                        );
                      });
                },
                child: Icon(Icons.filter_list),
              ),
              bottom: 16,
              right: 16,
            )
          ],
        );
      }),
    );
  }
}
