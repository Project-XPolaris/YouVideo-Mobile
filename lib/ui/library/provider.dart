import 'package:flutter/material.dart';
import 'package:youvideo/api/video.dart';

class LibraryProvider extends ChangeNotifier {
  final int libraryId;
  bool first = true;

  LibraryProvider({this.libraryId});

  VideoLoader loader = new VideoLoader();
  VideoLoader folderLoader = new VideoLoader();

  loadData() async {
    if (!first) {
      return;
    }
    first = false;
    await loadVideos();
    await loadDirectory();
    notifyListeners();
  }

  loadDirectory({force = false}) async {
    await folderLoader.loadData(
        extraFilter: {"libraryId": libraryId.toString(), "group": "base_dir"},force: force);
    if (force) {
      notifyListeners();
    }
  }

  loadVideos({force = false}) async {
    print("force load = " + force.toString());
    await loader.loadData(extraFilter: {"libraryId": libraryId.toString()},force: force);
    if (force) {
      notifyListeners();
    }
  }

  loadMoreVideo() async {
    if (await loader
        .loadMore(extraFilter: {"libraryId": libraryId.toString()})) {
      notifyListeners();
    }
  }

  loadMoreFolders() async {
    if (await loader.loadMore(extraFilter: {
      "libraryId": libraryId.toString(),
      "group": "base_dir"
    })) {
      notifyListeners();
    }
  }
}
