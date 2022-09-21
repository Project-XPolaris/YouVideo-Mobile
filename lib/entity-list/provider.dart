import 'package:flutter/material.dart';
import 'package:youvideo/api/entity.dart';

class HomeEntityProvider extends ChangeNotifier {
  EntitiesLoader loader = EntitiesLoader();
  loadData({bool force = false}) async {
    if (await loader.loadData(force:force)){
      notifyListeners();
    }
  }
  loadMore()async {
    await loader.loadMore();
    notifyListeners();
  }
}