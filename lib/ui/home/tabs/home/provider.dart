import 'package:flutter/material.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/api/history.dart';

class HomeTabProvider extends ChangeNotifier {
  bool first = true;
  VideoLoader latestVideoLoader = new VideoLoader();
  LibraryLoader libraryLoader = new LibraryLoader();
  TagLoader tagLoader = new TagLoader();
  EntitiesLoader entityLoader = new EntitiesLoader();
  MetaLoader metaLoader = new MetaLoader();
  HistoryLoader historyLoader = new HistoryLoader();

  loadData({force = false}) async {
    if (!first && !force) {
      return;
    }
    first = false;
    await latestVideoLoader.loadData(
      force: force,
      extraFilter: {"order": "id desc"},
    );
    await libraryLoader.loadData(extraFilter: {"pageSize": "5"}, force: force);
    await entityLoader.loadData(extraFilter: {"pageSize": "10"}, force: force);
    await metaLoader.loadData(extraFilter: {"pageSize": "12"}, force: force);
    await tagLoader.loadData(extraFilter: {"pageSize": "10"}, force: force);
    await historyLoader.loadData(
      extraFilter: {"pageSize": "10", "order": "id desc"},
      force: force,
    );
    notifyListeners();
  }
}
