import 'package:flutter/cupertino.dart';
import 'package:youvideo/api/library.dart';

class HomeLibrariesProvider extends ChangeNotifier {
  LibraryLoader loader = new LibraryLoader();

  loadData({force = false}) async {
    if (await loader.loadData(force: force)) {
      notifyListeners();
    }
  }

  loadMore() async {
    if (await loader.loadMore()) {
      notifyListeners();
    }
  }
}
