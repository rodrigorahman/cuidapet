import 'package:cuidapet/app/utils/store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader {
  static void show() {
    Get.dialog(Container(
      width: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      ),
    ));
  }

  static void hide() {
    Get.back();
  }

  static void run(StoreState state, {VoidCallback onLoaded, VoidCallback onError}) {
    
    switch (state) {
      case StoreState.loading:
        Loader.show();
        break;
      case StoreState.error:
        Loader.hide();
        if (onError != null) {
          onError();
        }
        break;
      case StoreState.loaded:
        Loader.hide();
        if (onLoaded != null) {
          onLoaded();
        }
        break;
      default:
    }
  }
}
