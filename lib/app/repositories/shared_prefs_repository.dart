import 'dart:convert';

import 'package:cuidapet/app/models/address_model.dart';
import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  
  static const _DEVICE_TOKEN = '/DEVICE_TOKEN/';
  static const _ACCESS_TOKEN = '/ACCESS_TOKEN/';
  static const _ADDRESS_SELECTED = '/ADDRESS_SELECTED/';
  static const _USER_DATA = '/USER_DATA/';
  static const _IS_SUPPLIER = '/IS_SUPPLIER/';
  
  final SharedPreferences prefs;

  SharedPrefsRepository._(this.prefs);

  static Future<SharedPrefsRepository> get instance async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsRepository._(prefs);
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

  Future<void> setIsSupplier(bool isSupplier) async {
    await prefs.setBool(_IS_SUPPLIER, isSupplier);
  }

  bool get isSupplier => prefs.containsKey(_IS_SUPPLIER) ? prefs.getBool(_IS_SUPPLIER) : false;
}