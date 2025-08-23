import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/entity/provider.dart';
import 'package:youvideo/ui/components/MetasSection.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/video/vertical.dart';

class EntityVerticalPage extends StatelessWidget {
  const EntityVerticalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntityProvider>(context);

    Future<void> onVideoTap(Video video) async {
      var resp = await ApiClient().fetchVideo(video.id!);
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Text(resp.data?.name ?? ""),
          );
        },
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  provider.entity?.name ?? "",
                  style: TextStyle(fontSize: 16.0),
                ),
                background: HeaderCover(url: provider.coverUrl),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    child: Cover(url: provider.coverUrl),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(provider.entity?.name ?? ""),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 12),
                child: ExpandableText(
                  provider.summary,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 5,
                  linkColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              provider.infos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: MetasSection(metas: provider.infos),
                    )
                  : Container(),
              // Episode chips
              provider.displayEPS != null && provider.displayEPS!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Episode"),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          height: 64,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: () {
                              final list = [...provider.displayEPS!];
                              list.sort((a, b) {
                                if ((a.order ?? double.infinity) >
                                    (b.order ?? double.infinity)) {
                                  return 1;
                                }
                                return -1;
                              });
                              return list.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    onVideoTap(e);
                                  },
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(e.ep ?? e.name ?? ""),
                                    ),
                                  ),
                                );
                              }).toList();
                            }(),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              provider.videos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 24),
                      height: 220,
                      child: VideosHorizonCollection(
                        videos: provider.videos,
                        title: "Videos",
                        titleStyle: TextStyle(fontWeight: FontWeight.w600),
                        onTap: (v) async {
                          await onVideoTap(v);
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
