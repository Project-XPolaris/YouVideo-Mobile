import 'package:flutter/material.dart';
import 'package:youvideo/api/tag.dart';

class HomeTagsProvider extends ChangeNotifier {
  TagLoader loader = new TagLoader();
  loadData({force = false}) async {
    if (await loader.loadData(force: force)){
      notifyListeners();
    }
  }
  loadMore() async {
    print("load more");
    if (await loader.loadMore()){
      notifyListeners();
    }
  }
}