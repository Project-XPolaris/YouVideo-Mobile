import 'package:filesize/filesize.dart';
import 'package:youvideo/util/format.dart';

import '../config.dart';

class File {
  int id;
  String cover;
  String path;
  String name;
  num duration;
  int size;
  String main_video_codec;
  String main_audio_codec;
  String subtitles;

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
  }
  getCoverUrl(){
    if (cover != null){
      return ApplicationConfig().serviceUrl + cover;
    }
  }

  String getStreamUrl(){
    return '${ApplicationConfig().serviceUrl}/video/file/$id/stream';
  }
  String getSubtitlesUrl(){
    return '${ApplicationConfig().serviceUrl}/video/file/$id/subtitles';
  }
  String getDurationText(){
   return formatDuration(Duration(seconds: duration.ceil()));
  }
  String getSizeText(){
    return filesize(this.size);
  }

  String getDescriptionText(){
    List<String> parts = [getSizeText(),main_video_codec,main_audio_codec];
    return parts.join(" | ");
  }

  String getPlayUrl(){
    return "${ApplicationConfig().serviceUrl}/video/file/$id/stream";
  }
}