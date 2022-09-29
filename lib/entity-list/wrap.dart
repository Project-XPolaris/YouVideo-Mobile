import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/entity-list/provider.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';

import '../ui/components/EntityFilter.dart';
import 'horizon.dart';



class EntityListWrap extends StatelessWidget {
  const EntityListWrap({Key? key}) : super(key: key);
  static launch(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EntityListWrap()));
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeEntityProvider>(
        create: (_) => HomeEntityProvider(),
        child:
        Consumer<HomeEntityProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Scaffold(
            appBar: AppBar(
              title: Text("Entity List"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: ScreenWidthSelector(
              verticalChild: HomeEntityHorizonView(
                provider: provider,
              ),
              horizonChild: HomeEntityHorizonView(
                provider: provider,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return EntityFilterView(
                        filter: provider.filter,
                        onChange: (filter) {
                          provider.filter = filter;
                          provider.loadData(force: true);
                        },
                      );
                    });
              },
              child: Icon(Icons.filter_list),
            ),
          );
        }));
  }
}
