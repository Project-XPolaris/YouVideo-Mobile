import 'package:flutter/material.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

class LibraryProvider extends ChangeNotifier {
  final int libraryId;
  bool first = true;
  VideoFilter filter = new VideoFilter(order: "id desc");
  int index = 0;
  LibraryProvider({required this.libraryId});

  VideoLoader loader = new VideoLoader();
  FolderLoader folderLoader = new FolderLoader();

  Map<String, String> _getVideosExtraParams() {
    Map<String, String> result = {
      "order": filter.order,
      "library": libraryId.toString(),
      "pageSize":"100",
    };
    if (filter.random) {
      result["random"] = "1";
    }
    return result;
  }

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
        extraFilter: {"library": libraryId.toString(), "group": "base_dir","pageSize":"50"},
        force: force);
    if (force) {
      notifyListeners();
    }
  }

  loadVideos({force = false}) async {
    await loader.loadData(extraFilter: _getVideosExtraParams(), force: force);
    if (force) {
      notifyListeners();
    }
  }

  loadMoreVideo() async {
    if (await loader.loadMore(extraFilter: _getVideosExtraParams())) {
      notifyListeners();
    }
  }

  loadMoreFolders() async {
    if (await folderLoader.loadMore(extraFilter: {
      "library": libraryId.toString(),
    })) {
      notifyListeners();
    }
  }
  setIndex(int index){
    this.index = index;
    notifyListeners();
  }
}
