import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/components/EntityGridView.dart';
import 'package:youvideo/ui/components/EntityList.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/entity/wrap.dart';
import 'package:youvideo/ui/library/provider.dart';

import '../../../components/EntityFilter.dart';

class EntityListView extends StatelessWidget {
  const EntityListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LibraryProvider>(context);
    return ScreenWidthSelector(
      horizonChild: Container(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await provider.loadEntity(force: true);
            },
            child: EntityGridView(
              physics: AlwaysScrollableScrollPhysics(),
              entities: provider.entityLoader.list,
              onItemClick: (entity) {
                EntityPage.Launch(context, entity.id);
              },
              onLoadMore: () {
                provider.loadMoreEntity();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return EntityFilterView(
                      filter: provider.entityFilter,
                      onChange: (filter) {
                        provider.entityFilter = filter;
                        provider.loadEntity(force: true);
                      },
                    );
                  });
            },
            child: Icon(Icons.filter_list),
          ),
        ),
      ),
      verticalChild: Container(
        child: EntityList(
          entities: provider.entityLoader.list,
          onItemClick: (entity) {
            EntityPage.Launch(context, entity.id);
          },
          onLoadMore: () {
            provider.loadMoreEntity();
          },
        ),
      ),
    );
  }
}
