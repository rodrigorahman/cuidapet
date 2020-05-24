import 'package:cuidapet/app/modules/login/change_password_modal/change_password_modal_widget.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:oktoast/oktoast.dart';

import 'login_controller.dart';

class LoginReactions with Disposable {
  final LoginController _controller;
  List<ReactionDisposer> disposer;

  LoginReactions(this._controller);

  void start() {
    disposer = [
      reaction((_) => _controller.loginState, (f) {
        Loader.run(f, onError: () {
          showToast(_controller.errorMessage, backgroundColor: Colors.red);
        });
      }),
      reaction((_) => _controller.confirmLoginState, (f) {
        Loader.run(f, onError: () async {
          showToast(_controller.errorMessage, backgroundColor: Colors.red);
          final prefs = await SharedPrefsRepository.instance;
          await prefs.clear();
        });
      }),
    ];
  }

  @override
  void dispose() {
    disposer.forEach((d) => d());
  }
}
