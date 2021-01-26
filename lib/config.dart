import 'package:shared_preferences/shared_preferences.dart';

class ApplicationConfig {
  static final apiUrl = "";
  static final ApplicationConfig _singleton = ApplicationConfig._internal();
  String serviceUrl = apiUrl;

  factory ApplicationConfig() {
    return _singleton;
  }

  ApplicationConfig._internal();

  Future<bool> loadConfig() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    serviceUrl = sharedPreferences.getString("apiUrl");
    print("load config complete");
    return true;
  }

  Future<bool> checkConfig() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isExist = sharedPreferences.containsKey("apiUrl");
    if (!isExist) {
      return false;
    }
    return true;
  }


}
