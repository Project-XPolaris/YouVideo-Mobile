import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youui/components/TitleSection.dart';
import 'package:youvideo/config.dart';
import 'package:youvideo/plugin/mx.dart';

import '../../api/file.dart';
import '../player/player.dart';
import 'ActionSelectBottomSheet.dart';

class FilesSection extends StatelessWidget {
  final List<File> files;

  const FilesSection({Key? key, this.files = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSection(
        title: "Files",
        child: Column(
          children: [
            ...files.map((e) => Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        List<ActionItem> actions = [
                          ActionItem(
                              title: "YouVideo player",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlayerView(file: e)),
                                );
                              }),
                          ActionItem(
                              title: "External player",
                              onTap: () async {
                                Navigator.pop(context);
                                if (Platform.isAndroid) {
                                  MXPlayerPlugin plugin = MXPlayerPlugin();
                                  var config = ApplicationConfig();
                                  String playUrl = e.getStreamUrl();
                                  var token = config.token;
                                  if (e.subtitles == null) {
                                    plugin.play(playUrl);
                                  } else {
                                    plugin.playWithSubtitles(
                                        playUrl, e.getSubtitlesUrl());
                                  }
                                }
                                if (Platform.isIOS) {
                                  String _url =
                                      "vlc-x-callback://x-callback-url/stream?url=${e.videoPlayLink}";
                                  if (e.subtitles != null) {
                                    _url += "&sub=${e.subtitlePlayLink}";
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
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(
                          Icons.videocam_rounded,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      trailing: Text(e.getDurationText()),
                    ),
                  ],
                ))
          ],
        ));
  }
}
