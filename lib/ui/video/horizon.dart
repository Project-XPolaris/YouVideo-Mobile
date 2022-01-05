import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youui/components/TitleSection.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/ui/video/VideoPage.dart';
import 'package:youvideo/ui/video/provider.dart';
import 'package:youvideo/ui/videos/wrap.dart';

import '../../plugin/mx.dart';
import '../components/ActionSelectBottomSheet.dart';
import '../components/AddTagBottomDialog.dart';
import '../components/VideosHorizonCollection.dart';

class VideoHorizonPage extends StatelessWidget {
  final VideoProvider provider;

  const VideoHorizonPage({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      height: 300,
                      width: double.infinity,
                      child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              top: 16,
                              left: 16,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 22,
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Cover(
                                    url: provider.coverUrl,
                                    width: 180,
                                    height: 180,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 16),
                                      child: Text(
                                        provider.video?.name ?? "Unknown",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Expanded(
                      child: Container(
                        color: Colors.black26,
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          provider.infos.isNotEmpty?TitleSection(
                            title: "Meta",
                            child: Wrap(
                              children: [
                                ...provider.infos.map((meta) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      child: ActionChip(
                                        label: Text(meta.value ?? ""),
                                        onPressed: () {
                                          VideosPageWrap.launchWithMetaVideo(
                                              context, meta);
                                        },
                                        avatar: CircleAvatar(
                                          child: Text("#"),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ):Container(),
                          TitleSection(
                            title: "Tags",
                            child: Wrap(
                              children: [
                                ...provider.tagLoader.list.map((tag) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: GestureDetector(
                                      child: ActionChip(
                                        label: Text(tag.name),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideosPageWrap(
                                                      title: tag.name,
                                                      filter: {
                                                        "tag": tag.id.toString()
                                                      },
                                                    )),
                                          );
                                        },
                                        avatar: CircleAvatar(
                                          child: Text("#"),
                                        ),
                                      ),
                                      onLongPress: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Wrap(children: [
                                                ListTile(
                                                  leading: Icon(Icons.delete),
                                                  title: Text("Remove tag"),
                                                  onTap: () {
                                                    var id = tag.id;
                                                    if (id != null) {
                                                      provider.removeTag(id);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                                Container(
                                                  height: 16,
                                                )
                                              ]);
                                            });
                                      },
                                    ),
                                  );
                                }).toList(),
                                ActionChip(
                                  label: Text("add tag"),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return AddTagBottomDialog(
                                            onCreate: (text) {
                                              Navigator.pop(context);
                                              provider.addTag(text);
                                            },
                                          );
                                        },
                                        isScrollControlled: true,
                                        useRootNavigator: true);
                                  },
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: Icon(Icons.add),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.black,
                    child: ListView(
                      children: [
                        TitleSection(
                            title: "Files",
                            child: Column(
                              children: [
                                ...provider.files.map((e) => Column(
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          onTap: () {
                                            List<ActionItem> actions = [
                                              ActionItem(
                                                  title: "External player",
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                    if (Platform.isAndroid) {
                                                      MXPlayerPlugin plugin =
                                                          MXPlayerPlugin();
                                                      var config =
                                                          ApplicationConfig();
                                                      String playUrl =
                                                          e.getStreamUrl();
                                                      var token = config.token;
                                                      if (token != null &&
                                                          token.isNotEmpty) {
                                                        playUrl +=
                                                            "?token=${token}";
                                                      }
                                                      if (e.subtitles == null) {
                                                        plugin.play(playUrl);
                                                      } else {
                                                        plugin.playWithSubtitles(
                                                            playUrl,
                                                            e.getSubtitlesUrl());
                                                      }
                                                    }
                                                    if (Platform.isIOS) {
                                                      String _url =
                                                          "vlc-x-callback://x-callback-url/stream?url=${e.getStreamUrl()}";
                                                      if (e.subtitles != null) {
                                                        _url +=
                                                            "&sub=${e.getSubtitlesUrl()}";
                                                      }
                                                      void _launchURL() async =>
                                                          await canLaunch(_url)
                                                              ? await launch(
                                                                  _url)
                                                              : throw 'Could not launch $_url';
                                                      _launchURL();
                                                    }
                                                  })
                                            ];
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (ctx) {
                                                  return ActionSelectBottomSheet(
                                                    height: 200,
                                                    actions: actions,
                                                    title: "Select to play",
                                                  );
                                                });
                                          },
                                          title: Text(e.name),
                                          subtitle:
                                              Text(e.getDescriptionText()),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.videocam_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: Text(e.getDurationText()),
                                        ),
                                      ],
                                    ))
                              ],
                            )),
                        provider.getSameDirectoryVideo().isNotEmpty?Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Container(
                            height: 180,
                            child: VideosHorizonCollection(
                              baseHeight: 120,
                              videos: provider.getSameDirectoryVideo(),
                              title: "Same directory",
                              titleStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ):Container(),
                        Container(
                          margin: EdgeInsets.only(top: 32),
                          child: Container(
                            height: 180,
                            child: VideosHorizonCollection(
                              baseHeight: 120,
                              videos: provider.entityVideos,
                              title: "In entity",
                              titleStyle: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
