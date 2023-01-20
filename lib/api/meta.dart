import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';

class Meta {
  int? id;
  String? key;
  String? value;

  Meta.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    key = json['key'] as String?;
    value = json['value'] as String?;
  }
}

class MetaLoader extends ApiDataLoaderWithBaseResponse<Meta> {
  @override
  Future<BaseResponse<ListResponseWrap<Meta>>> fetchData(
      Map<String, String> params) {
    return ApiClient().fetchMetaList(params);
  }
}
