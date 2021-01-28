import 'package:flutter/material.dart';
import 'package:youvideo/api/video.dart';

class HomeTabProvider extends ChangeNotifier {
  bool first = true;
  VideoLoader latestVideoLoader = new VideoLoader();
  loadData() async {
    if (!first) {
      return;
    }
    first = false;
    await latestVideoLoader.loadData();
    notifyListeners();
  }
}