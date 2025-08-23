import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/home/appbar.dart';
import 'package:youvideo/ui/home/provider.dart';

class BaseHomeLayout extends StatelessWidget {
  final Widget? child;
  final List<Widget> extra;

  const BaseHomeLayout({Key? key, this.child, this.extra = const []})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    bool isWide = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: renderHomeAppBar(context, actions: this.extra),
      body: Container(
        child: Row(
          children: [
            isWide
                ? NavigationRail(
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_rounded),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.videocam_rounded),
                        label: Text('Videos'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.explore_rounded),
                        label: Text('Explore'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_rounded),
                        label: Text('My'),
                      ),
                    ],
                    selectedIndex: provider.activeTab,
                    onDestinationSelected: (index) {
                      provider.setActiveTab(index);
                    },
                  )
                : Container(),
            Expanded(child: Container(child: child)),
          ],
        ),
      ),
      bottomNavigationBar: isWide
          ? null
          : SafeArea(
              child: NavigationBar(
                selectedIndex: provider.activeTab,
                onDestinationSelected: (index) {
                  provider.setActiveTab(index);
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.videocam_outlined),
                    selectedIcon: Icon(Icons.videocam_rounded),
                    label: 'Videos',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.explore_outlined),
                    selectedIcon: Icon(Icons.explore_rounded),
                    label: 'Explore',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: 'My',
                  ),
                ],
              ),
            ),
    );
  }
}
