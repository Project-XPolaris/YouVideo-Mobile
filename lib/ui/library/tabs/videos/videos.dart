import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/library/tabs/videos/list-wrap.dart';

class LibraryVideos extends StatelessWidget {
  final LibraryProvider provider;

  LibraryVideos({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await provider.loadVideos(force: true);
            },
            child: VideoListView(provider: provider,),
          ),
          Positioned(
            child: FloatingActionButton(
              onPressed: () {
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
      ),
    );
  }
}
