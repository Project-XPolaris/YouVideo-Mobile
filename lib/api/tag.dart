import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';

class Tag {
  int? id;
  String name = "";

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class TagLoader extends ApiDataLoaderWithBaseResponse<Tag> {
  @override
  Future<BaseResponse<ListResponseWrap<Tag>>> fetchData(
      Map<String, String> params) {
    return ApiClient().fetchTagList(params);
  }
}
