import 'dart:convert';

class AddressModel {
  int id;
  String address;
  double latitude;
  double longitude;
  String complemento;

  AddressModel({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.complemento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'complemento': complemento,
    };
  }

  static AddressModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    
    return AddressModel(
      id: map['id'] as int,
      address: map['address'],
      latitude: map['latitude'].runtimeType == String ? double.parse(map['latitude']) : map['latitude'] as double,
      longitude: map['latitude'].runtimeType == String ? double.parse(map['longitude']) : map['longitude'] as double,
      complemento: map['complemento'],
    );
  }

  String toJson() => json.encode(toMap());

  static AddressModel fromJson(String source) => fromMap(json.decode(source));
}
