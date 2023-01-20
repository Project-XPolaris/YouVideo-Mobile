import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';

import '../config.dart';

class History {
  int? videoId;
  String name = "";
  String? cover;

  History.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    name = json['name'];
    cover = json['cover'];
  }

  String? getCoverUrl() {
    var coverUrl = cover;
    var serviceUrl = ApplicationConfig().serviceUrl;
    if (coverUrl != null && serviceUrl != null) {
      return "${serviceUrl}${coverUrl}?token=${ApplicationConfig().token}";
    }
  }
}

class HistoryLoader extends ApiDataLoaderWithBaseResponse<History> {
  @override
  Future<BaseResponse<ListResponseWrap<History>>> fetchData(
      Map<String, String> params) {
    return ApiClient().fetchHistoryList(params);
  }
}
