import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/navigation.dart';
import 'package:youui/components/viewport-selector.dart';
import 'package:youui/layout/home/home-horizon.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/ui/library/provider.dart';
import 'package:youvideo/ui/library/tabs/folders/folders.dart';
import 'package:youvideo/ui/library/tabs/videos/videos.dart';

class LibraryPage extends StatelessWidget {
  final String title;
  final Library library;

  LibraryPage({required this.title, required this.library});
  static Launch(BuildContext context,Library library){
    if (library.id == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LibraryPage(
            title: library.name ?? "",
            library: library,
          )),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryProvider>(
        create: (_) => LibraryProvider(libraryId: library.id ?? 0),
        child: Consumer<LibraryProvider>(builder: (context, provider, child) {
          provider.loadData();
          getContent(){
            switch (provider.index) {
              case 0:
                return LibraryVideos(
                  provider: provider,
                );
              case 1:
                return LibraryFolders(
                  provider: provider,
                );
            }
            return Container();
          }
          return ViewportSelector(
              verticalChild: DefaultTabController(
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
                      },
                      child: TabBarView(
                        children: [
                          LibraryVideos(
                            provider: provider,
                          ),
                          LibraryFolders(
                            provider: provider,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            horizonChild: HomeTabLayoutHorizon(
              verticalNavigation: VerticalNavigationView(
                showBack: true,
                navItems: [
                  NavigationBarItem(icon: Icon(Icons.movie), label: "videos"),
                  NavigationBarItem(icon: Icon(Icons.folder),label: "folders")
                ],
                navigationStyle: NavigationStyle(
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.white54,
                  backgroundColor: Color(0xff424242)
                ),
                tabIndex: provider.index,
                onTabIndexChange: provider.setIndex,
              ),
              body: getContent(),
            ),
          );
        }));
  }
}
