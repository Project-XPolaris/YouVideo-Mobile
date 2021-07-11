class Info {
  bool success;
  bool authEnable;
  String authUrl;
  bool transEnable;

  Info.fromJson(Map<String, dynamic> json) {
    authEnable = json['authEnable'];
    authUrl = json['authUrl'];
    transEnable = json['transEnable'];
    success = json['success'];
  }
}