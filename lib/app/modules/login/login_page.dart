import 'dart:io';

import 'package:cuidapet/app/modules/login/login_reactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cuidapet/app/modules/login/components/facebook_button.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    Modular.get<LoginReactions>().start();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      if (Platform.isAndroid) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: ScreenUtil.screenHeightDp > 700 ? ThemeUtils.primaryColor : null,
            statusBarColor: Colors.white,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: ScreenUtil.screenWidthDp,
                height: ScreenUtil.screenHeightDp < 700 ? 800 : ScreenUtil.screenHeightDp * .95,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/login_background.png'), fit: BoxFit.fill, repeat: ImageRepeat.noRepeat),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 30),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Image.asset('assets/images/logo.png', width: ScreenUtil().setWidth(400), fit: BoxFit.fill), _buildForm()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.loginEditController,
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontSize: 25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login obrigatório';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.passwordEditController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(fontSize: 25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Senha obrigatória';
                }

                return null;
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp,
              height: 60,
              child: RaisedButton(
                color: ThemeUtils.primaryColor,
                onPressed: () => controller.login(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ou',
                      style: TextStyle(color: ThemeUtils.primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(
              onTap: () => controller.facebookLogin(),
            )
          ],
        ),
      ),
    );
  }
}
