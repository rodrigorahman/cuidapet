import 'package:json_annotation/json_annotation.dart';

part 'facebook_model.g.dart';

@JsonSerializable()
class FacebookModel {

  String id;
  @JsonKey(name: 'name')
  String fullName;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;
  String email;

  @JsonKey(name: 'picture', fromJson: _pictureFromJson)
  String picture;

  String largePicture;


  FacebookModel(this.id, this.fullName, this.firstName, this.lastName,
      this.email, this.picture, this.largePicture);

  factory FacebookModel.fromJson(Map<String, dynamic> json) => _$FacebookModelFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookModelToJson(this);

  static _pictureFromJson(data) {
    print(data);
    return data['data']['url'];
  }


  @override
  String toString() {
    return 'FacebookModel(id: $id, fullName: $fullName, firstName: $firstName, lastName: $lastName, email: $email, picture: $picture, largePicture: $largePicture)';
  }
}
