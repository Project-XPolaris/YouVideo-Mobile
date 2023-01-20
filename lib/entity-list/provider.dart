import 'package:flutter/material.dart';
import 'package:youvideo/api/entity.dart';
import 'package:youvideo/ui/components/EntityFilter.dart';

class HomeEntityProvider extends ChangeNotifier {
  EntitiesLoader loader = EntitiesLoader();
  EntityFilter filter = EntityFilter(order: "id desc");

  Map<String, String> _getVideosExtraParams() {
    Map<String, String> result = {
      "order": filter.order,
    };
    if (filter.random) {
      result["random"] = "1";
    }
    return result;
  }

  loadData({bool force = false}) async {
    if (await loader.loadData(
        force: force, extraFilter: _getVideosExtraParams())) {
      notifyListeners();
    }
  }

  loadMore() async {
    await loader.loadMore(extraFilter: _getVideosExtraParams());
    notifyListeners();
  }
}
