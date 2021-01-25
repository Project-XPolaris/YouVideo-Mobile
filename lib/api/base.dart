class ListResponseWrap<T> {
  int count;
  List<T> result;
  int page;
  int pageSize;

  ListResponseWrap({this.count, this.result, this.page, this.pageSize});

  ListResponseWrap.fromJson(
      Map<String, dynamic> json, Function(dynamic) converter) {
    count = json['count'];
    page = json['page'];
    pageSize = json['pageSize'];
    if (json['result'] != null) {
      result = new List<T>();
      json['result'].forEach((v) {
        result.add(converter(v));
      });
    }
  }
}
