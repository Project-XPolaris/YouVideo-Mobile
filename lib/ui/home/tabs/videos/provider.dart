import 'package:flutter/widgets.dart';
import 'package:youvideo/api/video.dart';

class HomeVideosProvider extends ChangeNotifier {
    VideoLoader loader = new VideoLoader();
    loadData() async {
      if (await loader.loadData()){
        notifyListeners();
      }
    }
    loadMore() async {
      if (await loader.loadMore()){
        notifyListeners();
      }
    }
}