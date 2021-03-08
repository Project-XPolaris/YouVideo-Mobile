import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/library/tabs/folders/folders.dart';
import 'package:youvideo/ui/library/tabs/videos/videos.dart';
import 'package:youvideo/util/listview.dart';

class LibraryPage extends StatelessWidget {
  final String title;
  final int libraryId;
  LibraryPage({this.title,this.libraryId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryProvider>(
        create: (_) => LibraryProvider(libraryId: libraryId),
        child:
        Consumer<LibraryProvider>(builder: (context, provider, child) {
          provider.loadData();
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0x1F1F1F),
                title: Text(title),
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.movie)),
                    Tab(icon: Icon(Icons.folder)),
                  ],
                ),
              ),
              body: Container(
                color: Color(0xFF121212),
                child: RefreshIndicator(
                  onRefresh: () async {
                    provider.loader.firstLoad = true;

                    await provider.loader.loadData();
                    return true;
                  },
                  child: TabBarView(
                    children: [
                      LibraryVideos(provider: provider,),
                      LibraryFolders(provider: provider,)
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
