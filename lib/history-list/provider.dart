import 'package:flutter/widgets.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/config.dart';

class HistoryListProvider extends ChangeNotifier {
  HistoryLoader loader = new HistoryLoader();

  Map<String, String> _getExtraParams() {
    Map<String, String> result = {
      "token": ApplicationConfig().token ?? "",
    };
    return result;
  }

  loadData({force = false}) async {
    var result =
        await loader.loadData(force: force, extraFilter: _getExtraParams());
    if (result) {
      notifyListeners();
    }
  }

  loadMore() async {
    if (await loader.loadMore(extraFilter: _getExtraParams())) {
      notifyListeners();
    }
  }
}
