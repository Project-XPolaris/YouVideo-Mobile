import 'package:flutter/material.dart';
import 'package:youvideo/api/meta.dart';
import 'package:youvideo/ui/components/MetaFilter.dart';

class HomeMetaProvider extends ChangeNotifier {
  final MetaLoader loader = new MetaLoader();
  final MetaLoader typeLoader = new MetaLoader();
  MetaFilter metaFilter = MetaFilter();

  loadData({bool force = false}) async {
    Map<String, String> paramMap = {};
    if (metaFilter.key != null) {
      paramMap['key'] = metaFilter.key!;
    }
    await loader.loadData(extraFilter: paramMap, force: force);
    if (await typeLoader.loadData(
        extraFilter: {"dist": "1", "pageSize": "100"}, force: force)) {
      notifyListeners();
    }
  }

  loadMore() async {
    Map<String, String> paramMap = {};
    if (metaFilter.key != null) {
      paramMap['key'] = metaFilter.key!;
    }

    if (await loader.loadMore(extraFilter: paramMap)) {
      notifyListeners();
    }
    ;
  }
}
