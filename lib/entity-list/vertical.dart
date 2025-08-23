import 'package:flutter/material.dart';
import 'package:youvideo/entity-list/provider.dart';
import 'package:youvideo/ui/components/EntityList.dart';
import 'package:youvideo/ui/entity/wrap.dart';

class HomeEntityVerticalView extends StatelessWidget {
  final HomeEntityProvider provider;

  const HomeEntityVerticalView({Key? key, required this.provider})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: () async {
        await provider.loadData(force: true);
      },
      child: EntityList(
        entities: provider.loader.list,
        onItemClick: (entity) {
          EntityPage.Launch(context, entity.id);
        },
        onLoadMore: () {
          provider.loadMore();
        },
      ),
    );
  }
}
