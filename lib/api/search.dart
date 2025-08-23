import 'package:youvideo/api/video.dart';
import 'package:youvideo/api/entity.dart' as yv;

class SearchResult {
  List<Video> videos = [];
  List<yv.Entity> entities = [];

  SearchResult.fromJson(Map<String, dynamic> json) {
    videos = [];
    entities = [];
    final Map<String, dynamic>? data = json['data'];
    if (data != null) {
      List<dynamic>? rawVideos = data['videos'];
      if (rawVideos != null) {
        for (var value in rawVideos) {
          videos.add(Video.fromJson(value));
        }
      }
      List<dynamic>? rawEntities = data['entities'];
      if (rawEntities != null) {
        for (var value in rawEntities) {
          entities.add(yv.Entity.fromJson(value));
        }
      }
    }
  }
}
