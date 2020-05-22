import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:oktoast/oktoast.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioRepository _repository;
  final loginEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  final confirmarSenhaEditController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _CadastroControllerBase(this._repository);

  Future<void> salvarUsuario() async {
    try {
      if (formKey.currentState.validate()) {
        Loader.show();
        await _repository.createUsuario(loginEditController.text, passwordEditController.text);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: loginEditController.text, password: passwordEditController.text);
        Loader.hide();
        showToast('Usuário criado com sucesso');
        Modular.to.pop();
      }
    } catch (e) {
      print(e);
      Loader.hide();
      showToast('Erro ao criar usuário tente novamente mais tarde');
    }
  }
}
