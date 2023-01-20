import 'package:filesize/filesize.dart';
import 'package:youvideo/util/format.dart';

import '../config.dart';

class Subtitles {
  int? id;
  String? label;

  Subtitles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  String get displayLabel {
    if (this.label == null || this.label == "") {
      return "default";
    }
    return this.label!;
  }
}

class File {
  int? id;
  String? cover;
  String? path;
  String name = "Unknown";
  num? duration;
  int? size;
  String? main_video_codec;
  String? main_audio_codec;
  List<Subtitles>? subtitles;
  int? coverWidth;
  int? coverHeight;
  int? videoId;

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    cover = json['cover'];
    name = json['name'];
    duration = json['duration'];
    size = json['size'];
    main_audio_codec = json['main_audio_codec'];
    main_video_codec = json['main_video_codec'];
    coverWidth = json['coverWidth'];
    coverHeight = json['coverHeight'];
    videoId = json['video_id'];
    if (json.containsKey("subtitles")) {
      subtitles = List<Subtitles>.from(
          json['subtitles'].map((it) => Subtitles.fromJson(it)).toList());
    }
  }

  double get ratio {
    if (coverHeight == 0) {
      return 1;
    }
    if (coverWidth == null || coverHeight == null) return 1;
    return coverWidth! / coverHeight!;
  }

  String? getCoverUrl() {
    var coverUrl = cover;
    var serviceUrl = ApplicationConfig().serviceUrl;
    if (coverUrl != null && serviceUrl != null) {
      return serviceUrl + coverUrl + "?token=${ApplicationConfig().token}";
    }
  }

  String get videoPlayLink {
    return '${ApplicationConfig().serviceUrl}/link/${id}/video/${ApplicationConfig().token}/a';
  }

  String getSubtitlePlayLinkWithSubId(int subId) {
    return '${ApplicationConfig().serviceUrl}/link/${id}/subs/${ApplicationConfig().token}/${subId}';
  }

  String getDurationText() {
    return formatDuration(Duration(seconds: duration?.ceil() ?? 0));
  }

  String getSizeText() {
    return filesize(this.size);
  }

  String getDescriptionText() {
    List<String> parts = [
      getSizeText(),
      main_video_codec ?? "Unknown video codec",
      main_audio_codec ?? "Unknown audio codec"
    ];
    return parts.join(" | ");
  }
}
