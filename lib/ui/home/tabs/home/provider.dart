import 'package:flutter/material.dart';
import 'package:youvideo/api/video.dart';

class HomeTabProvider extends ChangeNotifier {
  bool first = true;
  VideoLoader latestVideoLoader = new VideoLoader();
  loadData({force = false}) async {
    if (!first && !force) {
      return;
    }
    first = false;
    await latestVideoLoader.loadData();
    notifyListeners();
  }
}