import 'package:youui/account/entry.dart';
import 'package:youvideo/api/video.dart';

class SearchResult {
  List<Video> videos = [];
  List<Entity> entities = [];

  SearchResult.fromJson(Map<String, dynamic> json) {
    videos = [];
    entities = [];
    List<dynamic>? rawVideos = json['result']['videos'];
    if (rawVideos != null) {
      for (var value in rawVideos) {
        videos.add(Video.fromJson(value));
      }
    }
    List<dynamic>? rawEntities = json['result']['entities'];
    if (rawEntities != null) {
      for (var value in rawEntities) {
        entities.add(Entity.fromJson(value));
      }
    }
  }
}
