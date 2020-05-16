import 'package:json_annotation/json_annotation.dart';

part 'access_service_model.g.dart';

@JsonSerializable()
class AccessServiceModel {

  @JsonKey(name: 'access_token')
  String accessToken;
  
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  @JsonKey(ignore: true)
  bool created = false;

  AccessServiceModel();

  factory AccessServiceModel.fromJson(Map<String, dynamic> json) => _$AccessServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccessServiceModelToJson(this);

  @override
  String toString() => 'AccessServiceModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}
