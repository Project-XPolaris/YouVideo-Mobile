import 'package:flutter/cupertino.dart';
import 'package:youvideo/api/entity.dart';

class EntityProvider extends ChangeNotifier {
  final int id;
  final EntitiesLoader _loader = EntitiesLoader();
  Entity? entity;
  EntityProvider({required this.id});
  bool firstLoad = true;
  get entityName => entity?.name ?? "Unknown";
  get coverUrl => entity?.coverUrl  ?? "";
  get infos => entity?.infos ?? [];
  get videos => entity?.videos ?? [];
  loadData()async {
    if (!firstLoad) {
      return;
    }
    firstLoad = false;
    await _loader.loadData(extraFilter: {"id":id.toString()});
    if (_loader.list.isNotEmpty) {
      entity = _loader.list[0];
    }
    notifyListeners();

  }
}