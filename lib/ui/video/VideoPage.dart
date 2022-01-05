import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/plugin/mx.dart';
import 'package:youvideo/ui/components/ActionSelectBottomSheet.dart';
import 'package:youvideo/ui/components/AddTagBottomDialog.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/video/provider.dart';
import 'package:youvideo/ui/videos/videos.dart';
import 'dart:io' show Platform;

import 'package:youvideo/ui/videos/wrap.dart';

class VideoPageVertical extends StatelessWidget {
  final VideoProvider provider;

  VideoPageVertical({required this.provider});

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
                  title: Text(provider.video?.name ?? "",
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
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cover(
                    url: provider.coverUrl,
                    width: 120,
                    height: 120,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(provider.video?.name ?? ""),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        "Meta",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Wrap(
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  "Tags",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w600),
                ),
              ),
              Wrap(
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
                                  builder: (context) => VideosPageWrap(
                                        title: tag.name,
                                        filter: {"tag": tag.id.toString()},
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Files",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
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
                                    MXPlayerPlugin plugin = MXPlayerPlugin();
                                    var config = ApplicationConfig();
                                    String playUrl = e.getStreamUrl();
                                    var token = config.token;
                                    if (token != null && token.isNotEmpty) {
                                      playUrl += "?token=${token}";
                                    }
                                    if (e.subtitles == null) {
                                      plugin.play(playUrl);
                                    } else {
                                      plugin.playWithSubtitles(
                                          playUrl, e.getSubtitlesUrl());
                                    }
                                  }
                                  if (Platform.isIOS) {
                                    String _url =
                                        "vlc-x-callback://x-callback-url/stream?url=${e.getStreamUrl()}";
                                    if (e.subtitles != null) {
                                      _url += "&sub=${e.getSubtitlesUrl()}";
                                    }
                                    void _launchURL() async =>
                                        await canLaunch(_url)
                                            ? await launch(_url)
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
                        subtitle: Text(e.getDescriptionText()),
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
                  )),
              provider.getSameDirectoryVideo().isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 32),
                      height: 260,
                      child: VideosHorizonCollection(
                        baseHeight: 120,
                        videos: provider.getSameDirectoryVideo(),
                        title: "Same directory",
                        titleStyle: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w600),
                      ),
                    )
                  : Container(),
              provider.entityVideos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 32),
                      height: 260,
                      child: VideosHorizonCollection(
                        baseHeight: 120,
                        videos: provider.getSameDirectoryVideo(),
                        title: "In entity",
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

class HeaderCover extends StatelessWidget {
  final String? url;

  HeaderCover({this.url});

  @override
  Widget build(BuildContext context) {
    var coverUrl = url;
    if (coverUrl == null) {
      return Container(
        color: Colors.white24,
        child: Center(
          child: Icon(
            Icons.videocam_rounded,
            size: 48,
            color: Colors.white24,
          ),
        ),
      );
    }
    return Image.network(
      coverUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.videocam_rounded,
            size: 48,
            color: Colors.red,
          ),
        );
      },
    );
  }
}

class Cover extends StatelessWidget {
  final String? url;
  final double width;
  final double height;

  Cover({this.url, this.width = 64, this.height = 64});

  @override
  Widget build(BuildContext context) {
    var coverUrl = url;
    if (coverUrl == null) {
      return Container(
        height: height,
        width: width,
        color: Colors.white12,
        child: Center(
          child: Icon(Icons.videocam_rounded),
        ),
      );
    }
    return Image.network(
      coverUrl,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          width: width,
          color: Colors.white10,
          child: Center(
            child: Icon(
              Icons.videocam_rounded,
              size: 48,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
