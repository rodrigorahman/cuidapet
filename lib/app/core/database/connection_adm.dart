import 'package:cuidapet/app/database/connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionADM extends WidgetsBindingObserver with Disposable{

  ConnectionADM() {
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var connection = Connection();
    print(state);
    switch (state) {
      case AppLifecycleState.inactive:
        connection.closeConnection();
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        connection.closeConnection();
        break;
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

}