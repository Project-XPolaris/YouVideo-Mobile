class ListResponseWrap<T> {
  int? count;
  List<T> result = [];
  int? page;
  int? pageSize;

  ListResponseWrap(
      {this.count, required this.result, this.page, this.pageSize});

  ListResponseWrap.fromJson(
      Map<String, dynamic> json, Function(dynamic) converter) {
    count = json['count'];
    page = json['page'];
    pageSize = json['pageSize'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(converter(v));
      });
    }
  }

  int getPage() {
    return page ?? 1;
  }

  int getPageSize() {
    return pageSize ?? 0;
  }

  int getTotal() {
    return count ?? 0;
  }
}

class BaseResponse<T> {
  late bool success;
  String? err;
  String? code;
  T? data;

  BaseResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic) converter) {
    success = json['success'];
    err = json['err'];
    code = json['code'];
    if (json['data'] != null) {
      data = converter(json['data']);
    }
  }
}
