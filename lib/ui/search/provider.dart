import 'package:flutter/material.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/video.dart';

class SearchProvider extends ChangeNotifier {
  String searchKey;
  VideoLoader videoLoader = new VideoLoader();
  TagLoader tagLoader = new TagLoader();
  bool isSearching = false;
  setSearchKey(String text){
    searchKey = text;
    notifyListeners();
  }
  search() async {
    if (isSearching) {
      return;
    }
    isSearching = true;
    notifyListeners();
    await videoLoader.loadData(force: true,extraFilter: {"search":searchKey,"pageSize":"5"});
    await tagLoader.loadData(force: true,extraFilter: {"search":searchKey,"pageSize":"5"});
    isSearching = false;
    notifyListeners();
  }
}