import 'package:flutter/material.dart';
import 'package:youvideo/entity-list/provider.dart';
import 'package:youvideo/ui/components/EntityGridView.dart';
import 'package:youvideo/ui/entity/wrap.dart';

class HomeEntityHorizonView extends StatelessWidget {
  final HomeEntityProvider provider;
  const HomeEntityHorizonView({Key? key,required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
      children: [
        Container(
          child: RefreshIndicator(
            color: Theme.of(context).colorScheme.primary,
            onRefresh: () async {
              await provider.loadData(force: true);
            },
            child: Container(
              child: EntityGridView(
               entities: provider.loader.list,
                onItemClick: (entity) {
                  EntityPage.Launch(context, entity.id);
                },
                onLoadMore: (){
                  provider.loadMore();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
