import 'package:flutter/material.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/api/folder.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

import '../../config.dart';

class LibraryProvider extends ChangeNotifier {
  final int libraryId;
  bool first = true;
  VideoFilter filter = new VideoFilter(order: "id desc");
  int index = 0;
  LibraryProvider({required this.libraryId,required this.title});
  final String title;
  VideoLoader loader = new VideoLoader();
  FolderLoader folderLoader = new FolderLoader();
  EntitiesLoader entityLoader = new EntitiesLoader();
  String GridViewMode = ApplicationConfig().config.LibraryViewGridViewType;
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
    await loadEntity();
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
  loadEntity({force = false}) async {
    await entityLoader.loadData(
        extraFilter: {"library": libraryId.toString(), "pageSize":"50"},
        force: force);
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
  loadMoreEntity() async {
    if (await entityLoader.loadMore(extraFilter: {
      "library": libraryId.toString(),
    })) {
      notifyListeners();
    }
  }
  setIndex(int index){
    this.index = index;
    notifyListeners();
  }
  int get gridItemWidth {
    if (GridViewMode == "Small") {
      return 150;
    } else if (GridViewMode == "Medium") {
      return 180;
    } else if (GridViewMode == "Large") {
      return 220;
    }
    return 180;
  }

  updateGridViewType(String type) {
    GridViewMode = type;
    ConfigData newConfig = ApplicationConfig().config;
    newConfig.LibraryViewGridViewType = type;
    ApplicationConfig().UpdateData(newConfig);
    notifyListeners();
  }
}
