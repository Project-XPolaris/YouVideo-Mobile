import 'package:flutter/services.dart';

class MXPlayerPlugin {
  static const _methodMessageChannel = MethodChannel("mxplugin");
  play(String url,{String token = ""}) {
    _methodMessageChannel.invokeMethod("play",{"playUrl":url,"token":token});
  }
  playWithSubtitles(String url,String subtitlesUrl,{String token = ""}) {
    _methodMessageChannel.invokeMethod("playWithSubtitles",{"playUrl":url,"subtitlesUrl":subtitlesUrl,"token":token});
  }
}