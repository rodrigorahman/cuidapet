import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

class AppWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.top,
      textStyle: TextStyle(fontSize: 20, color: Colors.white),
      textPadding: EdgeInsets.all(20),
      backgroundColor: Color(0xFFA8CE4B),
      child: GetMaterialApp(
        navigatorKey: Modular.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Cuidapet',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFFA8CE4B),
          primaryColorDark: Color(0xFF689F38),
          primaryColorLight: Color(0xFFDCEDC8),
          accentColor: Color(0xFF4CAF50),
        ),
        initialRoute: '/',
        onGenerateRoute: Modular.generateRoute,
      ),
    );
  }
}
