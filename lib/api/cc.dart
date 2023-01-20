class CC {
  int? index;
  String? text;
  int? start;
  int? end;

  CC.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    text = json['text'];
    start = json['start'];
    end = json['end'];
  }
}
