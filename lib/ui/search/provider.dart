import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/tag.dart';

import '../../api/search.dart';

class SearchProvider extends ChangeNotifier {
  String? searchKey;
  TagLoader tagLoader = new TagLoader();
  SearchResult? searchResult;
  bool isSearching = false;

  setSearchKey(String text) {
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
    this.searchResult = await ApiClient().search(key);
    await tagLoader
        .loadData(force: true, extraFilter: {"search": key, "pageSize": "5"});
    isSearching = false;
    notifyListeners();
  }
}
