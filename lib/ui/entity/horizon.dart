import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/ui/entity/provider.dart';

import '../components/MetasSection.dart';
import '../components/VideoPlayView.dart';
import '../components/VideosHorizonCollection.dart';
import '../video/vertical.dart';

class EntityHorizonPage extends StatelessWidget {
  const EntityHorizonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntityProvider>(context);
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 300,
              child: Container(
                child: ListView(
                  children: [
                    Container(
                        width: double.infinity,
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(top: 72),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 240,
                                        height: 180,
                                        child: Cover(
                                          url: provider.coverUrl,
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: Text(
                                            provider.entity?.name ?? "Unknown",
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 32,
                                left: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: ExpandableText(
                        provider.summary,
                        expandText: 'show more',
                        collapseText: 'show less',
                        maxLines: 5,
                        linkColor: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    provider.infos.isNotEmpty
                        ? MetasSection(
                            metas: provider.infos,
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Wrap(
                        children: [
                          ...provider.tags.map((e) {
                            return Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.all(6),
                              child: Text(
                                e.value ?? "",
                                style: TextStyle(fontSize: 12),
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.circular(4)),
                            );
                          }).toList()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        provider.entity != null
                            ? Container(
                                margin: EdgeInsets.only(top: 32),
                                child: Container(
                                  height: 180,
                                  child: VideosHorizonCollection(
                                    videos: provider.videos,
                                    title: "Videos",
                                    onTap: (video) async {
                                      var resp = await ApiClient()
                                          .fetchVideo(video.id!);
                                      showModalBottomSheet(
                                          constraints:
                                              BoxConstraints(maxWidth: 1200),
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          builder: (ctx) {
                                            return VideoPlayView(
                                              file: resp.data!.files.first,
                                            );
                                          });
                                    },
                                    titleStyle:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          height: 120,
                          child: ListView(
                            children: [
                              ...provider.metas.map((meta) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 16),
                                  padding: EdgeInsets.all(8),
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: Center(
                                          child: Text(
                                            meta.value ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(fontSize: 13),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                                      Container(
                                        child: Text(
                                          meta.name ?? "",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer),
                                );
                              })
                            ],
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
