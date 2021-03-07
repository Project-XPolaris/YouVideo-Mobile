import 'package:flutter/cupertino.dart';
import 'package:youvideo/api/library.dart';

class HomeLibrariesProvider extends ChangeNotifier {
  LibraryLoader loader = new LibraryLoader();
  loadData() async {
    if (await loader.loadData()){
      notifyListeners();
    }
  }
  loadMore() async {
    if (await loader.loadMore()){
      notifyListeners();
    }
  }
}