import 'package:flutter/material.dart';
import 'package:youvideo/ui/video/vertical.dart';
import 'package:youvideo/ui/video/provider.dart';

import '../components/FilesSection.dart';
import '../components/MetasSection.dart';
import '../components/TagsSection.dart';
import '../components/VideosHorizonCollection.dart';

class VideoHorizonPage extends StatelessWidget {
  final VideoProvider provider;

  const VideoHorizonPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(provider.tagLoader.list);
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 300,
              child: Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          provider.video?.name ?? "Unknown",
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
                                    Icons.arrow_back_rounded,
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
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    child: ListView(children: [
                      provider.infos.isNotEmpty
                          ? MetasSection(
                              metas: provider.infos,
                            )
                          : Container(),
                      TagsSection(
                        tags: provider.tagLoader.list,
                        onAdd: (tag) {
                          provider.addTag(tag);
                        },
                        onRemove: (tag) {
                          final id = tag.id;
                          if (id != null) {
                            provider.removeTag(id);
                          }
                        },
                      ),
                    ]),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        FilesSection(files: provider.files),
                        provider.getSameDirectoryVideo().isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 32),
                                child: Container(
                                  height: 180,
                                  child: VideosHorizonCollection(
                                    baseHeight: 120,
                                    videos: provider.getSameDirectoryVideo(),
                                    title: "Same directory",
                                    titleStyle:
                                        TextStyle(),
                                  ),
                                ),
                              )
                            : Container(),
                        provider.entity != null && provider.entityVideos.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(top: 32),
                                child: Container(
                                  height: 180,
                                  child: VideosHorizonCollection(
                                    baseHeight: 120,
                                    videos: provider.entityVideos,
                                    title: "In entity",
                                    titleStyle:
                                        TextStyle(),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
