import 'package:flutter/material.dart';
import 'package:cuidapet/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/push_notification/firebase_message_configure.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await loadEnv();
  FirebaseMessageConfigure().configure();

  runApp(ModularApp(module: AppModule()));
}

Future loadEnv() async {
  const bool inProduction = const bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(inProduction ? '.env' : '.env_dev');
}
