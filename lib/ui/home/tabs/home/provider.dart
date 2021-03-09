import 'package:flutter/material.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';

class HomeTabProvider extends ChangeNotifier {
  bool first = true;
  VideoLoader latestVideoLoader = new VideoLoader();
  LibraryLoader libraryLoader = new LibraryLoader();
  TagLoader tagLoader = new TagLoader();

  loadData({force = false}) async {
    if (!first && !force) {
      return;
    }
    first = false;
    await latestVideoLoader.loadData(force: force,extraFilter: {"order":"id desc"});
    await libraryLoader.loadData(extraFilter: {"pageSize":"5"},force: force);
    await tagLoader.loadData(extraFilter: {"pageSize":"10"},force: force);
    notifyListeners();
  }
}