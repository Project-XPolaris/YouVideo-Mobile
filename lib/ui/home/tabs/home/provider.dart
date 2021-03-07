import 'package:flutter/material.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/video.dart';

class HomeTabProvider extends ChangeNotifier {
  bool first = true;
  VideoLoader latestVideoLoader = new VideoLoader();
  LibraryLoader libraryLoader = new LibraryLoader();
  loadData({force = false}) async {
    if (!first && !force) {
      return;
    }
    first = false;
    await latestVideoLoader.loadData();
    await libraryLoader.loadData(extraFilter: {"pageSize":"5"});
    notifyListeners();
  }
}