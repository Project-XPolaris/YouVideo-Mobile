
import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';

class VideoProvider extends ChangeNotifier {
  final int videoId;
  Video? video;
  VideoProvider({required this.videoId});
  String? coverUrl;
  List<File> files = [];
  TagLoader tagLoader = new TagLoader();
  final EntitiesLoader _entityLoader = EntitiesLoader();
  VideoLoader sameDirectoryVideo = new VideoLoader();
  List<Meta> get infos => video?.infos ?? [];
  Entity? get entity  {
    if (_entityLoader.list.isEmpty) {
      return null;
    }
    return _entityLoader.list.first;
  }
  List<Video> get entityVideos {
    return entity?.videos ?? [];
  }
  Future<void> loadData() async {
    if (video != null) {
      return;
    }
    video = await ApiClient().fetchVideo(videoId);
    if (video != null) {
      if (video!.files.isNotEmpty) {
        coverUrl = video!.files.first.getCoverUrl();
        files = video!.files;
      }
      await tagLoader.loadData(extraFilter: {"video":video!.id.toString()});
      var entId = video?.entityId;
      if (entId != null) {
        await _entityLoader.loadData(extraFilter: {"id":entId.toString()});
      }
    }
    notifyListeners();
    await fetchSameVideoInDirectory();
  }
  Future addTag(String name) async  {
    await ApiClient().createTag(name, [videoId]);
    await tagLoader.loadData(force: true,extraFilter: {"video":video!.id.toString()});
    notifyListeners();
  }
  Future removeTag(int tagId) async {
    await ApiClient().removeVideoFromTag(tagId, [videoId]);
    await tagLoader.loadData(force: true,extraFilter: {"video":video!.id.toString()});
    notifyListeners();
  }
  Future fetchSameVideoInDirectory() async {
    await sameDirectoryVideo.loadData(extraFilter: {
      "directoryVideo":videoId.toString(),
    },force: true);
    notifyListeners();
  }
  List<Video> getSameDirectoryVideo(){
    return sameDirectoryVideo.list.where((element) => element.id != videoId).toList();
  }
}