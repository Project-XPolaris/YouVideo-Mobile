import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/EntityGridView.dart';
import 'package:youvideo/ui/entity/wrap.dart';
import 'package:youvideo/ui/home/tabs/entity/provider.dart';

class HomeEntityHorizonView extends StatelessWidget {
  final HomeEntityProvider provider;
  const HomeEntityHorizonView({Key? key,required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Stack(
      children: [
        Container(
          child: RefreshIndicator(
            color: Colors.red,
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
        // Positioned(
        //   bottom: 16,
        //   right: 16,
        //   child: FloatingActionButton(
        //     child: Icon(Icons.filter_list),
        //     onPressed: () {
        //       provider.loadData(force: true);
        //       // showModalBottomSheet(
        //       //     context: context,
        //       //     builder: (ctx) {
        //       //       return Container();
        //       //     });
        //     },
        //   ),
        // )
      ],
    );
  }
}
