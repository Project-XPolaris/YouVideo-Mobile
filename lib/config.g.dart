// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigData _$ConfigDataFromJson(Map<String, dynamic> json) => ConfigData()
  ..HomeVideosGridViewType = json['HomeVideosGridViewType'] as String?
  ..HomeVideosLayout = json['HomeVideosLayout'] as String?
  ..LibraryViewGridViewType = json['LibraryViewGridViewType'] as String?;

Map<String, dynamic> _$ConfigDataToJson(ConfigData instance) =>
    <String, dynamic>{
      'HomeVideosGridViewType': instance.HomeVideosGridViewType,
      'HomeVideosLayout': instance.HomeVideosLayout,
      'LibraryViewGridViewType': instance.LibraryViewGridViewType,
    };
