// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookModel _$FacebookModelFromJson(Map<String, dynamic> json) {
  return FacebookModel(
    json['id'] as String,
    json['name'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['email'] as String,
    FacebookModel._pictureFromJson(json['picture']),
    json['largePicture'] as String,
  );
}

Map<String, dynamic> _$FacebookModelToJson(FacebookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'picture': instance.picture,
      'largePicture': instance.largePicture,
    };
