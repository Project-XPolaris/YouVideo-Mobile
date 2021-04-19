import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/plugin/mx.dart';
import 'package:youvideo/ui/components/ActionSelectBottomSheet.dart';
import 'package:youvideo/ui/components/AddTagBottomDialog.dart';
import 'package:youvideo/ui/player/player.dart';
import 'package:youvideo/ui/video/provider.dart';
import 'package:youvideo/ui/videos/videos.dart';

class VideoPage extends StatelessWidget {
  final int videoId;

  VideoPage({this.videoId});
  static const _methodMessageChannel = MethodChannel("mxplugin");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoProvider>(
        create: (_) => VideoProvider(videoId: videoId),
        child: Consumer<VideoProvider>(builder: (context, provider, child) {
          provider.loadData();
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cover(
                          url: provider.coverUrl,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(provider.video?.name ?? ""),
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
                                        builder: (context) => VideosPage(
                                          title: tag.name,
                                          filter: {"tag": tag.id.toString()},
                                        )),
                                  );
                                },
                                avatar: CircleAvatar(
                                  child: Text("#"),
                                ),
                              ),
                              onLongPress: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Wrap(children: [
                                        ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text("Remove tag"),
                                          onTap: (){
                                            provider.removeTag(tag.id);
                                            Navigator.pop(context);
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
                                color: Colors.white70,
                                fontWeight: FontWeight.w600),
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
                                      title: "Integrated player",
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Player(
                                                    playUrl: e.getPlayUrl(),
                                                subtitlesUrl: e.getSubtitlesUrl(),
                                                  )),
                                        );
                                      }),
                                  ActionItem(
                                      title: "External player",
                                      onTap: () async {
                                        Navigator.pop(context);
                                        MXPlayerPlugin plugin = MXPlayerPlugin();
                                        var config = ApplicationConfig();
                                        String playUrl = e.getStreamUrl();
                                        if (config.token != null && config.token.isNotEmpty) {
                                          playUrl += "?token=${config.token}";
                                        }
                                        if (e.subtitles == null) {
                                          plugin.play(playUrl);
                                        }else{
                                          plugin.playWithSubtitles(playUrl, e.getSubtitlesUrl());
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
                                child: Icon(Icons.videocam_rounded),
                              ),
                              trailing: Text(e.getDurationText()),
                            ),
                            Divider(
                              color: Colors.white24,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class HeaderCover extends StatelessWidget {
  final String url;

  HeaderCover({this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null) {
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
      url,
      fit: BoxFit.cover,
    );
  }
}

class Cover extends StatelessWidget {
  final String url;

  Cover({this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container(
        height: 64,
        width: 100,
        color: Colors.white12,
        child: Center(
          child: Icon(Icons.videocam_rounded),
        ),
      );
    }
    return Image.network(
      url,
      height: 64,
    );
  }
}
