class Info {
  bool authEnable;
  String authUrl;
  bool transEnable;

  Info.fromJson(Map<String, dynamic> json) {
    authEnable = json['authEnable'];
    authUrl = json['authUrl'];
    transEnable = json['transEnable'];
  }
}