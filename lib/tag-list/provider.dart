import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/tag.dart';

class TagListProvider extends ChangeNotifier {
  TagLoader loader = new TagLoader();
  loadData({force = false}) async {
    if (await loader.loadData(force: force)){
      notifyListeners();
    }
  }
  loadMore() async {
    if (await loader.loadMore()){
      notifyListeners();
    }
  }
  removeTag(int id)async{
    await ApiClient().removeTag(id);
    await loadData(force: true);
  }
}