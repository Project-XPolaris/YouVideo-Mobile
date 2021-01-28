
import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/file.dart';
import 'package:youvideo/api/video.dart';

class VideoProvider extends ChangeNotifier {
  final int videoId;
  Video video;
  VideoProvider({this.videoId});
  String coverUrl;
  List<File> files = [];
  Future<void> loadData() async {
    if (video != null) {
      return;
    }
    video = await ApiClient().fetchVideo(videoId);
    if (video.files != null && video.files.isNotEmpty) {
      coverUrl = video.files.first.getCoverUrl();
      files = video.files;
    }

    notifyListeners();
  }
}