// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessServiceModel _$AccessServiceModelFromJson(Map<String, dynamic> json) {
  return AccessServiceModel()
    ..accessToken = json['access_token'] as String
    ..refreshToken = json['refresh_token'] as String;
}

Map<String, dynamic> _$AccessServiceModelToJson(AccessServiceModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
