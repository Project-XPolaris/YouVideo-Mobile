
import 'package:flutter/cupertino.dart';
import 'package:youvideo/api/tag.dart';

class TagsProvider extends ChangeNotifier {
  final Map<String,String> extraFilter;
  final TagLoader loader = new TagLoader();
  TagsProvider({required this.extraFilter});
  loadData({force = false}) async {
    if (await loader.loadData(extraFilter:extraFilter,force: force)){
      notifyListeners();
    }
  }
  loadMore() async {
    if (await loader.loadMore(extraFilter: extraFilter)){
      notifyListeners();
    }
  }
}