import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:json_annotation/json_annotation.dart';
part 'config.g.dart';
@JsonSerializable()
class ConfigData {
  @JsonKey(required: true)
  String HomeVideosGridViewType = "Medium";
  @JsonKey(required: true)
  String LibraryViewGridViewType = "Medium";

  factory ConfigData.fromJson(Map<String, dynamic> json) => _$ConfigDataFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigDataToJson(this);
  ConfigData.initNew(){
    HomeVideosGridViewType = "Medium";
    LibraryViewGridViewType = "Medium";
  }
  ConfigData();
}

class ApplicationConfig {
  static final ApplicationConfig _singleton = ApplicationConfig._internal();
  String? serviceUrl;
  String? token;
  late ConfigData config;

  factory ApplicationConfig() {
    return _singleton;
  }

  ApplicationConfig._internal();

  Future<bool> loadConfig() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    serviceUrl = sharedPreferences.getString("apiUrl");
    if (sharedPreferences.containsKey("configData")){
      String? raw = sharedPreferences.getString("configData");
      if (raw != null) {
        config = ConfigData.fromJson(json.decode(raw));
      }
    }else{
      config = ConfigData.initNew();
    }
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

  UpdateData(ConfigData configData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("configData", jsonEncode(config));
    this.config = configData;
  }
}
