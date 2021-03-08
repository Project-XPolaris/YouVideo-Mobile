import 'package:flutter/widgets.dart';
import 'package:youvideo/api/video.dart';

class HomeVideosProvider extends ChangeNotifier {
    VideoLoader loader = new VideoLoader();
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