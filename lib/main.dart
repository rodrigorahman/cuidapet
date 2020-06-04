import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/push_notification/firebase_message_configure.dart';
import 'package:connectivity/connectivity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadEnv();
  await FirebaseMessageConfigure().configure();
  runApp(ModularApp(module: AppModule()));
}

Future loadEnv() async {
  const inProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(inProduction ? '.env' : '.env_dev');
}
