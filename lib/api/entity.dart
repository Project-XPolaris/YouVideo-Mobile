import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/api/video.dart';

import '../config.dart';

class Entity {
  String? name;
  int? id;
  String? cover;
  int? coverWidth;
  int? coverHeight;
  List<Video> videos = [];
  List<Meta> infos = [];
  Entity.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.id = json['id'];
    this.cover = json['cover'];
    this.coverWidth = json['coverWidth'];
    this.coverHeight = json['coverHeight'];
    if (json.containsKey("videos")){
      videos = List<Video>.from(json['videos'].map((it) => Video.fromJson(it)).toList());
    }
    if (json.containsKey("infos")){
      infos = List<Meta>.from(json['infos'].map((it) => Meta.fromJson(it)).toList());
    }
  }
  double get ratio {
    if (coverWidth == null || coverHeight == null) return 1;
    return coverWidth! / coverHeight!;
  }
  get displayName => name ?? "unknown";
  get coverUrl {
    var coverUrl = cover;
    var serviceUrl = ApplicationConfig().serviceUrl;
    if (coverUrl != null && serviceUrl != null){
      return serviceUrl + coverUrl;
    }
  }
}

class EntitiesLoader extends ApiDataLoader<Entity> {
  @override
  Future<ListResponseWrap<Entity>> fetchData(Map<String, String> params) {
    return ApiClient().fetchEntityList(params);
  }
}