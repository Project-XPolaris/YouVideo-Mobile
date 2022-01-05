import 'package:flutter/material.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/ui/components/MetaFilter.dart';
import 'package:youvideo/ui/home/tabs/meta/provider.dart';
import 'package:youvideo/ui/videos/wrap.dart';
import 'package:youvideo/util/listview.dart';

class HomeMetaHorizonView extends StatelessWidget {
  final HomeMetaProvider provider;
  const HomeMetaHorizonView({Key? key,required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = createLoadMoreController(provider.loadMore);
    return Scaffold(
      backgroundColor: Colors.black87,
      endDrawer: Drawer(
        child:MetaFilterView(
          filter: provider.metaFilter,
          onChange: (newFilter){
            provider.metaFilter = newFilter;
            provider.loadData(force: true);
          },
          keys: provider.typeLoader.list.map((e) => e.key!).toList(),
        ),
      ),
      body: Builder(builder: (context){
        return Stack(
          children: [
            Container(
              child: RefreshIndicator(
                color: Colors.red,
                onRefresh: () async {
                  await provider.loadData(force: true);
                },
                child: Container(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: provider.loader.list.length,
                    itemBuilder: (context, index) {
                      Meta meta = provider.loader.list[index];
                      return ListTile(
                        onTap: (){
                          VideosPageWrap.launchWithMetaVideo(context, meta);
                        },
                        title: Text(meta.value ?? ""),
                        subtitle: Text(meta.key ?? ""),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                child: Icon(Icons.filter_list),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
