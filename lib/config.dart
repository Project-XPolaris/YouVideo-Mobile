class ApplicationConfig {
  static final apiUrl = "http://192.168.31.193:7700";
  static final ApplicationConfig _singleton = ApplicationConfig._internal();
  String serviceUrl = apiUrl;

  factory ApplicationConfig() {
    return _singleton;
  }

  ApplicationConfig._internal();

  // Future<bool> loadConfig() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   serviceUrl = sharedPreferences.getString("apiUrl");
  //   print("load config complete");
  //   return true;
  // }
}
