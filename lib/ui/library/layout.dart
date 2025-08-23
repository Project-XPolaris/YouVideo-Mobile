import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youui/components/navigation.dart';
import 'package:youui/components/viewport-selector.dart';
import 'package:youui/layout/home/home-horizon.dart';
import 'package:youvideo/ui/library/provider.dart';

import '../components/GridViewModeMenu.dart';
import 'content.dart';
import 'tabs/entities/list-wrap.dart';
import 'tabs/folders/folders.dart';
import 'tabs/videos/videos.dart';

class LibraryLayout extends StatelessWidget {
  const LibraryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    return ViewportSelector(
      verticalChild: Scaffold(
        appBar: AppBar(
          title: Text(provider.title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              provider.loader.firstLoad = true;
              await provider.loader.loadData();
            },
            child: IndexedStack(
              index: provider.index,
              children: [
                EntityListView(),
                LibraryVideos(),
                LibraryFolders(provider: provider),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: NavigationBar(
            selectedIndex: provider.index,
            onDestinationSelected: (value) {
              provider.setIndex(value);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.apps_outlined),
                selectedIcon: Icon(Icons.apps_rounded),
                label: 'Entities',
              ),
              NavigationDestination(
                icon: Icon(Icons.movie_outlined),
                selectedIcon: Icon(Icons.movie_rounded),
                label: 'Videos',
              ),
              NavigationDestination(
                icon: Icon(Icons.folder_outlined),
                selectedIcon: Icon(Icons.folder_rounded),
                label: 'Folders',
              ),
            ],
          ),
        ),
      ),
      horizonChild: Scaffold(
        body: HomeTabLayoutHorizon(
          verticalNavigation: VerticalNavigationView(
            showBack: true,
            navItems: [
              NavigationBarItem(
                icon: Icon(Icons.apps_rounded),
                label: "Entities",
              ),
              NavigationBarItem(
                icon: Icon(Icons.movie_rounded),
                label: "Videos",
              ),
              NavigationBarItem(
                icon: Icon(Icons.folder_rounded),
                label: "Folders",
              ),
            ],
            tabIndex: provider.index,
            onTabIndexChange: provider.setIndex,
            action: Expanded(
              child: Column(
                children: [
                  provider.index == 1
                      ? GirdViewModeMenu(
                          onModeChange: (mode) {
                            provider.updateGridViewType(mode);
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          body: LibraryContent(),
        ),
      ),
    );
  }
}
