import 'package:flutter/material.dart';
import 'package:youvideo/ui/components/VideosHorizonCollection.dart';
import 'package:youvideo/ui/video/provider.dart';

import '../components/FilesSection.dart';
import '../components/MetasSection.dart';
import '../components/TagsSection.dart';

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
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(provider.video?.name ?? "",
                      style: TextStyle(
                        fontSize: 16.0,
                      )),
                  background: HeaderCover(
                    url: provider.coverUrl,
                  )),
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
                    child: Cover(
                      url: provider.coverUrl,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(provider.video?.name ?? ""),
                    ),
                  )
                ],
              ),
              provider.infos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: MetasSection(
                        metas: provider.infos,
                      ),
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 32, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [FilesSection(files: provider.files)],
                ),
              ),
              provider.getSameDirectoryVideo().isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 32),
                      height: 260,
                      child: VideosHorizonCollection(
                        videos: provider.getSameDirectoryVideo(),
                        title: "Same directory",
                        titleStyle: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )
                  : Container(),
              provider.entityVideos.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 32),
                      height: 260,
                      child: VideosHorizonCollection(
                        videos: provider.getSameDirectoryVideo(),
                        title: "In entity",
                        titleStyle: TextStyle(fontWeight: FontWeight.w600),
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
            color: Theme.of(context).colorScheme.primary,
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
    return Center(
      child: ClipRRect(
        child: Image.network(
          coverUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: width,
              color: Colors.white10,
              child: Center(
                child: Icon(
                  Icons.videocam_rounded,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          },
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
