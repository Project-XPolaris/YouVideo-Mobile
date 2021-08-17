class FetchEntityByNameResponse {
  Entity entity;
  bool success;

  FetchEntityByNameResponse({
      this.entity, 
      this.success});

  FetchEntityByNameResponse.fromJson(dynamic json) {
    entity = json["entity"] != null ? Entity.fromJson(json["entity"]) : null;
    success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (entity != null) {
      map["entity"] = entity.toJson();
    }
    map["success"] = success;
    return map;
  }

}

class Entity {
  String name;
  String state;
  String instance;
  int version;
  Export export;

  Entity({
      this.name, 
      this.state, 
      this.instance, 
      this.version, 
      this.export});

  Entity.fromJson(dynamic json) {
    name = json["name"];
    state = json["state"];
    instance = json["instance"];
    version = json["version"];
    export = json["export"] != null ? Export.fromJson(json["export"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["state"] = state;
    map["instance"] = instance;
    map["version"] = version;
    if (export != null) {
      map["export"] = export.toJson();
    }
    return map;
  }

}

class Export {
  List<String> urls;

  Export({
      this.urls});

  Export.fromJson(dynamic json) {
    urls = json["urls"] != null ? json["urls"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["urls"] = urls;
    return map;
  }

}