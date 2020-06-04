import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import 'no_connection_dialog.dart';

class ConnectionCheck extends Disposable {
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  var dialogOpen = false;
  Function callback;

  ConnectionCheck() {
    Connectivity().checkConnectivity().then((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        // openDialog();
      }
    });

    connectivitySubscription ??= Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        // openDialog();
      } else {
        // closeDialog();
      }
    });
  }

  void openDialog({Function callback}) {
    if (!dialogOpen) {
      this.callback = callback;
      dialogOpen = true;
      Get.dialog(NoConnectionDialog());
    }
  }

  void closeDialog() {
    if (dialogOpen) {
      dialogOpen = false;
      Get.back();
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    }
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
  }
}
