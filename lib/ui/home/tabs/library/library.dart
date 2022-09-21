import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/LibraryItem.dart';
import 'package:youvideo/ui/home/tabs/library/provider.dart';
import 'package:youvideo/ui/library/library.dart';
import 'package:youvideo/util/listview.dart';

import '../../layout.dart';

class LibrariesTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeLibrariesProvider>(
        create: (_) => HomeLibrariesProvider(),
        child: Consumer<HomeLibrariesProvider>(
            builder: (context, provider, child) {
              var controller = createLoadMoreController(() => provider.loadMore());
              provider.loadData();
              return BaseHomeLayout(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: RefreshIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    onRefresh: () async {
                      await provider.loadData(force: true);
                    },
                    child: ListView(
                      controller: controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: provider.loader.list.map((library) {
                        return LibraryItem(
                          library: library,
                          onTap: () {
                            LibraryPage.Launch(context, library);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }));
  }
}
