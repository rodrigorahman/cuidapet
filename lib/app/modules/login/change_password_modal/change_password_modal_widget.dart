import 'package:cuidapet/app/modules/login/change_password_modal/change_password_modal_controller.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ChangePasswordModalWidget extends StatelessWidget {
  final _controller = Modular.get<ChangePasswordModalController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _controller.formKey,
      child: Container(
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Escolha uma senha',
                  style: ThemeUtils.theme.textTheme.headline5,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(fontSize: 20),
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _controller.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (String value) {
                  if (value != _controller.passwordController.text) {
                    return 'Senhas não batem';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: ScreenUtil.screenWidthDp,
                height: 70,
                child: RaisedButton(
                  onPressed: () => _controller.changePassword(),
                  color: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Salvar',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
