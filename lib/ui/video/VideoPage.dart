import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/ui/video/provider.dart';

class VideoPage extends StatelessWidget {
  final int videoId;

  VideoPage({this.videoId});

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
                        background: HeaderCover(url: provider.coverUrl,)),
                  ),
                ];
              },
              body: Container(
                padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Cover(url: provider.coverUrl,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(provider.video?.name ?? ""),
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
                            final AndroidIntent intent = AndroidIntent(
                              action: 'action_view',
                              data: e.getStreamUrl(),
                              type: "video/*",
                              arguments: <String, dynamic>{},
                            );
                            intent.launch();
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
          child: Icon(Icons.videocam_rounded, size: 48, color: Colors.white24,),
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

