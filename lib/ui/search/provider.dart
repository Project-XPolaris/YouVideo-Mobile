import 'package:flutter/material.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/tag.dart';
import 'package:youvideo/api/library.dart';
import 'package:youvideo/api/meta.dart';

import '../../api/search.dart';

class SearchProvider extends ChangeNotifier {
  String? searchKey;
  TagLoader tagLoader = new TagLoader();
  SearchResult? searchResult;
  bool isSearching = false;
  List<Library> libraries = [];
  List<Meta> metas = [];

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
    try {
      // core search (videos + entities)
      this.searchResult = await ApiClient().search(key);
      // tags
      await tagLoader.loadData(
        force: true,
        extraFilter: {"search": key, "pageSize": "5"},
      );
      // libraries
      try {
        final libResp = await ApiClient().fetchLibraryList({
          "search": key,
          "pageSize": "5",
        });
        libraries = libResp.data?.result ?? [];
      } catch (_) {}
      // metas
      try {
        final metaResp = await ApiClient().fetchMetaList({
          "search": key,
          "pageSize": "5",
        });
        metas = metaResp.data?.result ?? [];
      } catch (_) {}
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }
}
