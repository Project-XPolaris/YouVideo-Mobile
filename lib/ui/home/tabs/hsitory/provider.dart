import 'package:flutter/widgets.dart';
import 'package:youvideo/api/history.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

class HomeHistoryListProvider extends ChangeNotifier {
  HistoryLoader loader = new HistoryLoader();
  Map<String,String> _getExtraParams() {
    Map<String,String> result = {

    };
    return result;
  }
  loadData({force = false}) async {
    if (await loader.loadData(force: force,extraFilter:_getExtraParams())) {
      notifyListeners();
    }
  }

  loadMore() async {
    if (await loader.loadMore(extraFilter: _getExtraParams())) {
      notifyListeners();
    }
  }
}