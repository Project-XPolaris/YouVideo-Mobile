import 'package:flutter/material.dart';
import 'package:youvideo/api/video.dart';
import 'package:youvideo/ui/components/VideoFilter.dart';

class VideosProvider extends ChangeNotifier {
  final Map<String,String> extraFilter;
  VideosProvider({this.extraFilter});
  VideoFilter filter = new VideoFilter(order: "id desc");
  VideoLoader loader = new VideoLoader();
  Map<String, String> _getVideosExtraParams() {
    Map<String, String> result = {
      "order": filter.order,
      ...extraFilter
    };
    return result;
  }
  loadData({force = false}) async {
    if (await loader.loadData(extraFilter: _getVideosExtraParams(),force: force)){
      notifyListeners();
    }
  }
  loadMore() async {
    if (await loader.loadMore(extraFilter: _getVideosExtraParams())){
      notifyListeners();
    }
  }
}