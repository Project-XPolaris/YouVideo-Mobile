import 'package:flutter/cupertino.dart';
import 'package:youvideo/api/client.dart';
import 'package:youvideo/api/entity.dart';

class EntityProvider extends ChangeNotifier {
  final int id;
  Entity? entity;

  EntityProvider({required this.id});

  bool firstLoad = true;

  get entityName => entity?.name ?? "Unknown";

  get coverUrl => entity?.coverUrl ?? "";

  get infos => entity?.infos ?? [];

  get videos => entity?.videos ?? [];

  List<EntityTag> get tags =>
      (entity?.tags ?? []).where((element) => element.name == "Tag").toList();

  List<EntityTag> get metas =>
      (entity?.tags ?? []).where((element) => element.name != "Tag").toList();

  String get summary => entity?.summary ?? "no summary";

  loadData() async {
    if (!firstLoad) {
      return;
    }
    firstLoad = false;
    var entityResponse = await ApiClient().fetchEntityById(id);
    if (entityResponse.success) {
      entity = entityResponse.data;
      notifyListeners();
    }
    notifyListeners();
  }
}
