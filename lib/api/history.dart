import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';

import '../config.dart';

class History {
  int videoId;
  String name;
  String cover;

  History.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    name = json['name'];
    cover = json['cover'];
  }

  getCoverUrl(){
    if (cover != null){
      return ApplicationConfig().serviceUrl + cover;
    }
  }
}

class HistoryLoader extends ApiDataLoader<History> {
  @override
  Future<ListResponseWrap<History>> fetchData(Map<String, String> params) {
    return ApiClient().fetchHistoryList(params);
  }
}