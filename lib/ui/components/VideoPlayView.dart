import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/ui/video/vertical.dart';

import '../../api/file.dart';
import '../../plugin/mx.dart';
import '../player/player.dart';
import '../player/player2.dart';

class VideoPlayView extends StatefulWidget {
  final File file;

  const VideoPlayView({Key? key, required this.file}) : super(key: key);

  @override
  State<VideoPlayView> createState() => _VideoPlayViewState();
}

class _VideoPlayViewState extends State<VideoPlayView> {
  int? subId;

  @override
  void initState() {
    super.initState();
    if (widget.file.subtitles != null && widget.file.subtitles!.isNotEmpty) {
      subId = widget.file.subtitles![0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      constraints: BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                child: Cover(
                  url: widget.file.getCoverUrl(),
                  width: 120,
                  height: 120,
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      widget.file.name,
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text("Subtitles"),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: Wrap(
                children: [
                  ...(widget.file.subtitles ?? []).map((e) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(e.displayLabel),
                        selected: this.subId == e.id,
                        onSelected: (isSelect) {
                          if (isSelect) {
                            setState(() {
                              subId = e.id;
                            });
                          }
                        },
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChewieDemo(file: widget.file,),
                            ));
                          },
                          child: Text("Internal player")),
                      margin: EdgeInsets.only(right: 16),
                    )),
                Flexible(
                    flex: 1,
                    child: Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              ApiClient()
                                  .createPlayHistory(widget.file.videoId!);
                              if (Platform.isAndroid) {
                                MXPlayerPlugin plugin = MXPlayerPlugin();
                                String playUrl = widget.file.videoPlayLink;
                                if (this.subId == null) {
                                  plugin.play(playUrl);
                                } else {
                                  plugin.playWithSubtitles(
                                      playUrl,
                                      widget.file.getSubtitlePlayLinkWithSubId(
                                          subId!));
                                }
                              }
                              if (Platform.isIOS) {
                                String _url =
                                    "vlc-x-callback://x-callback-url/stream?url=${widget.file.videoPlayLink}";
                                if (subId != null) {
                                  _url +=
                                      "&sub=${widget.file.getSubtitlePlayLinkWithSubId(subId!)}";
                                }
                                void _launchURL() async => await canLaunch(_url)
                                    ? await launch(_url)
                                    : throw 'Could not launch $_url';
                                _launchURL();
                              }
                            },
                            child: Text("External player"))))
              ],
            ),
          )
        ],
      ),
    );
  }
}
