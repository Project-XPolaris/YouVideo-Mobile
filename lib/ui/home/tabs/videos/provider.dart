import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

class HomeVideosProvider extends ChangeNotifier {
  VideoFilter filter = new VideoFilter(order: "id desc",random: false);

  VideoLoader loader = new VideoLoader();
  Map<String,String> _getExtraParams() {
    Map<String,String> result = {
      "order":filter.order,
      "pageSize":"25",
    };
    if (filter.random) {
      result["random"] = "1";
    }
    final year = filter.year;
    if (year != null) {
      var startDate = DateTime(int.parse(year),);
      var endDate = DateTime(int.parse(year) + 1);
      result["releaseStart"] = DateFormat('yyyy-MM-dd').format(startDate);
      result["releaseEnd"] = DateFormat('yyyy-MM-dd').format(endDate);
    }
    print(result);
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