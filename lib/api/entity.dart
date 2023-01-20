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
  String? summary;
  List<Meta> infos = [];
  List<EntityTag> tags = [];

  Entity.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.id = json['id'];
    this.cover = json['cover'];
    this.coverWidth = json['coverWidth'];
    this.coverHeight = json['coverHeight'];
    this.summary = json['summary'];
    if (json.containsKey("videos")) {
      videos = List<Video>.from(
          json['videos'].map((it) => Video.fromJson(it)).toList());
    }
    if (json.containsKey("infos")) {
      infos = List<Meta>.from(
          json['infos'].map((it) => Meta.fromJson(it)).toList());
    }
    if (json.containsKey("tags")) {
      tags = List<EntityTag>.from(
          json['tags'].map((it) => EntityTag.fromJson(it)).toList());
    }
  }

  double get ratio {
    if (coverWidth == null || coverHeight == null) return 1;
    return coverWidth! / coverHeight!;
  }

  get displayName => name ?? "unknown";

  String get displaySummary => summary ?? "no summary";

  get coverUrl {
    var coverUrl = cover;
    var serviceUrl = ApplicationConfig().serviceUrl;
    if (coverUrl != null && serviceUrl != null) {
      return serviceUrl + coverUrl + "?token=${ApplicationConfig().token}";
    }
  }
}

class EntitiesLoader extends ApiDataLoaderWithBaseResponse<Entity> {
  @override
  Future<BaseResponse<ListResponseWrap<Entity>>> fetchData(
      Map<String, String> params) {
    return ApiClient().fetchEntityList(params);
  }
}

class EntityTag {
  String? name;
  String? value;

  EntityTag.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.value = json['value'];
  }
}
