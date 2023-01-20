import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

class VideosProvider extends ChangeNotifier {
  final Map<String, String> extraFilter;

  VideosProvider({required this.extraFilter});

  VideoFilter filter = new VideoFilter(order: "id desc");
  VideoLoader loader = new VideoLoader();

  Map<String, String> _getVideosExtraParams() {
    Map<String, String> result = {"order": filter.order, ...extraFilter};
    final year = filter.year;
    if (year != null) {
      var startDate = DateTime(
        int.parse(year),
      );
      var endDate = DateTime(int.parse(year) + 1);
      result["releaseStart"] = DateFormat('yyyy-MM-dd').format(startDate);
      result["releaseEnd"] = DateFormat('yyyy-MM-dd').format(endDate);
    }
    return result;
  }

  loadData({force = false}) async {
    if (await loader.loadData(
        extraFilter: _getVideosExtraParams(), force: force)) {
      notifyListeners();
    }
  }

  loadMore() async {
    if (await loader.loadMore(extraFilter: _getVideosExtraParams())) {
      notifyListeners();
    }
  }
}
