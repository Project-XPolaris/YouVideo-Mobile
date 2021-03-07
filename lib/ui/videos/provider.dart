import 'package:flutter/material.dart';
import 'package:youvideo/api/video.dart';

class VideosProvider extends ChangeNotifier {
  final Map<String,String> extraFilter;
  VideosProvider({this.extraFilter});
  VideoLoader loader = new VideoLoader();
  loadData() async {
    if (await loader.loadData(extraFilter: extraFilter)){
      notifyListeners();
    }
  }
  loadMore() async {
    print("load more");
    if (await loader.loadMore(extraFilter: extraFilter)){
      notifyListeners();
    }
  }
}