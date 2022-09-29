import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/ui/components/ScreenWidthSelector.dart';
import 'package:youvideo/ui/videos/horizon.dart';
import 'package:youvideo/ui/videos/provider.dart';
import 'package:youvideo/ui/videos/vertical.dart';

class VideosPageWrap extends StatelessWidget {
  final Map<String,String> filter;
  final String title;

  const VideosPageWrap({Key? key,this.title = "Videos",required this.filter}) : super(key: key);
  static launchWithFolderDetail(BuildContext context,Folder folder){
    int? id = folder.id;
    if (id == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideosPageWrap(
            title: folder.name,
            filter: {"folder": folder.id.toString()},
          )),
    );
  }
  static launchWithMetaVideo(BuildContext context,Meta meta){
    int? id = meta.id;
    if (id == null) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VideosPageWrap(
            title: meta.value ?? "",
            filter: {"info": id.toString()},
          )),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideosProvider>(
        create: (_) => VideosProvider(extraFilter: filter),
        child: Consumer<VideosProvider>(builder: (context, provider, child) {
          provider.loadData();
          return ScreenWidthSelector(
            verticalChild: VideosVerticalPage(
              title: title,
              filter: filter,
              provider: provider,
            ),
            horizonChild: VideosHorizonPage(
              title: title,
              filter: filter,
              provider: provider,
            ),
          );
        }));
  }
}
