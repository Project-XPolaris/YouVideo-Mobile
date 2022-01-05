import 'package:flutter/material.dart';
import 'package:youvideo/ui/entity/provider.dart';
import 'package:youvideo/ui/videos/videos.dart';
import 'package:youvideo/ui/videos/wrap.dart';

import '../components/VideosHorizonCollection.dart';
import '../video/VideoPage.dart';

class EntityHorizonPage extends StatelessWidget {
  final EntityProvider provider;

  const EntityHorizonPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFF1F1F1F),
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(provider.entityName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: HeaderCover(
                    url: provider.coverUrl,
                  )),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.only(top: 0, left: 16, right: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cover(
                    url: provider.coverUrl,
                    width: 200,
                    height: 200,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(provider.entity?.name ?? ""),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  "Tags",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w600),
                ),
              ),
              provider.infos.isNotEmpty
                  ? Wrap(
                      children: [
                        ...provider.infos.map((meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: ActionChip(
                                label: Text(meta.value),
                                onPressed: () {
                                  VideosPageWrap.launchWithFolderDetail(
                                      context, meta.id);
                                },
                                avatar: CircleAvatar(
                                  child: Text("#"),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    )
                  : Container(),
              provider.videos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 32),
                      height: 260,
                      width: 1000,
                      child: VideosHorizonCollection(
                        baseHeight: 120,
                        videos: provider.videos,
                        title: "Video on ${provider.entityName}",
                        titleStyle: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w600),
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
