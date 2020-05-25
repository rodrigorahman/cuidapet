import 'package:cuidapet/app/models/usuario_model.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  
  @observable
  UsuarioModel usuario;

  @action
  Future<void> setUser(UsuarioModel userModel) async {
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registerUserData(userModel);
    usuario = userModel;
  }

  @action
  Future<void> loaderUserModel() async {
    usuario = (await SharedPrefsRepository.instance).userData;
  }

}