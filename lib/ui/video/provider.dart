
import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';

class VideoProvider extends ChangeNotifier {
  final int videoId;
  Video? video;
  VideoProvider({required this.videoId});
  String? coverUrl;
  List<File> files = [];
  TagLoader tagLoader = new TagLoader();
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
    }
    notifyListeners();
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
}