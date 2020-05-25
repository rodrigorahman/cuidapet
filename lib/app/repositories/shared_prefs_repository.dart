import 'dart:convert';

import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _DEVICE_TOKEN = '/DEVICE_TOKEN/';
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  static const _ADDRESS_SELECTED = '/ADDRESS_SELECTED/';
  static const _USER_DATA = '/USER_DATA/';
  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  String get deviceToken {
    return prefs.get(_DEVICE_TOKEN);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);
  

  void registerDeviceToken(String token) async {
    await prefs.setString(_DEVICE_TOKEN, token);
  }

  Future<void> registerAccessToken(String token) async => prefs.setString(_ACCESS_TOKEN, token);

  
  Future<void> registerUserData(UsuarioModel usuario) async => prefs.setString(_USER_DATA, jsonEncode(usuario));
  UsuarioModel get userData => UsuarioModel.fromJson(jsonDecode(prefs.get(_USER_DATA)));

  Future<void> clear() async {
    await prefs.clear();
  }

  void logout() {
    prefs.clear();
  }

  String get addressSelected {
    if(prefs.containsKey(_ADDRESS_SELECTED)) {
      return prefs.get(_ADDRESS_SELECTED);
    }
    return null;
  }

  Future<void> selectAddress(AddressModel address) async {
    await prefs.setString(_ADDRESS_SELECTED, address.toJson());
  }
}
