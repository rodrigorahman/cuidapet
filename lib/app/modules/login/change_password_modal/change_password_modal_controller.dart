import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet/app/repositories/login_repository.dart';
import 'package:cuidapet/app/utils/store_utils.dart';
import 'package:oktoast/oktoast.dart';

part 'change_password_modal_controller.g.dart';

class ChangePasswordModalController = _ChangePasswordModalControllerBase with _$ChangePasswordModalController;

abstract class _ChangePasswordModalControllerBase with Store {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginRepository _repository;

  _ChangePasswordModalControllerBase(
    this._repository,
  );

  Future<void> changePassword() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await this._repository.changePassword(passwordController.text);
        Loader.hide();
        // Fechando o BottomSheet
        Get.back();
      } catch (e) {
        print(e);
        Loader.hide();
        showToast('Erro ao alterar senha'); 
      }
    }
  }
}
