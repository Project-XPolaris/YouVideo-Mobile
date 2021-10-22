import 'package:youvideo/api/base.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/loader.dart';

class Library {
  int? id;
  String? name;
  String? path;

  Library.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
  }
  String getName(){
    return name ?? "Unknown library";
  }
}
class LibraryLoader extends ApiDataLoader<Library> {
  @override
  Future<ListResponseWrap<Library>> fetchData(Map<String, String> params) {
    return ApiClient().fetchLibraryList(params);
  }
}