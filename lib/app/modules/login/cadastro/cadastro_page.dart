import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

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
                labelText: 'E-mail',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'E-mail obrigatório';
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
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Senha obrigatória';
                }else if(value.length < 6) {
                  return 'Senha deve conter pelo menos 6 caracteres';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: controller.confirmarSenhaEditController,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                labelStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              validator: (String value) {
                if (value != controller.passwordEditController.text) {
                  return 'Confirmar Senha diferente de senha';
                }

                return null;
              },
            ),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.all(10),
              width: ScreenUtil.screenWidthDp,
              height: 60,
              child: RaisedButton(
                color: ThemeUtils.primaryColor,
                onPressed: () => controller.salvarUsuario(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
