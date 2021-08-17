class Info {
  String name;
  bool success;
  bool authEnable;
  String authUrl;
  bool transEnable;

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    authEnable = json['authEnable'];
    authUrl = json['authUrl'];
    transEnable = json['transEnable'];
    success = json['success'];
  }
}