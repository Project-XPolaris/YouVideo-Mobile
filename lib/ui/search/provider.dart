import 'package:flutter/material.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';

class SearchProvider extends ChangeNotifier {
  String? searchKey;
  VideoLoader videoLoader = new VideoLoader();
  TagLoader tagLoader = new TagLoader();
  bool isSearching = false;
  setSearchKey(String text){
    searchKey = text;
    notifyListeners();
  }
  search() async {
    var key = searchKey;
    if (isSearching || key == null || key.isEmpty) {
      return;
    }
    isSearching = true;
    notifyListeners();
    await videoLoader.loadData(force: true,extraFilter: {"search":key,"pageSize":"5"});
    await tagLoader.loadData(force: true,extraFilter: {"search":key,"pageSize":"5"});
    isSearching = false;
    notifyListeners();
  }
}