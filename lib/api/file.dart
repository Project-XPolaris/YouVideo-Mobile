import 'package:filesize/filesize.dart';
import 'package:youvideo/util/format.dart';
import '../config.dart';
import 'dart:io' show Platform;

class File {
  int? id;
  String? cover;
  String? path;
  String name = "Unknown";
  num? duration;
  int? size;
  String? main_video_codec;
  String? main_audio_codec;
  String? subtitles;
  int? coverWidth;
  int? coverHeight;

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    cover = json['cover'];
    name = json['name'];
    duration = json['duration'];
    size = json['size'];
    main_audio_codec = json['main_audio_codec'];
    main_video_codec = json['main_video_codec'];
    subtitles = json['subtitles'];
    coverWidth = json['coverWidth'];
    coverHeight = json['coverHeight'];
  }
  double get ratio {
    if (coverWidth == null || coverHeight == null) return 1;
    return coverWidth! / coverHeight!;
  }
  String? getCoverUrl() {
    var coverUrl = cover;
    var serviceUrl = ApplicationConfig().serviceUrl;
    if (coverUrl != null && serviceUrl != null){
      return serviceUrl + coverUrl + "";
    }
  }

  String getStreamUrl(){
    String url = '${ApplicationConfig().serviceUrl}/video/file/$id/stream';
    String? token = ApplicationConfig().token;
    if (token != null){
      Platform.isAndroid ? url += '?token=$token' : url += "%3ftoken%3d${token}";;
    }

    return url;
  }
  String getSubtitlesUrl(){
    return '${ApplicationConfig().serviceUrl}/video/file/$id/subtitles';
  }
  String getDurationText(){

   return formatDuration(Duration(seconds: duration?.ceil() ?? 0));
  }
  String getSizeText(){
    return filesize(this.size);
  }

  String getDescriptionText(){
    List<String> parts = [getSizeText(),main_video_codec ?? "Unknown video codec",main_audio_codec ?? "Unknown audio codec"];
    return parts.join(" | ");
  }

  String getPlayUrl(){
    return "${ApplicationConfig().serviceUrl}/video/file/$id/stream?token=${ApplicationConfig().token}";
  }
}