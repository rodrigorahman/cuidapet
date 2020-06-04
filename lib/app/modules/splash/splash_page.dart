import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:cuidapet/app/shared/auth_store.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = 'Splash'}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ScreenUtil.init(context);
      ThemeUtils.init(context);
//      final prefs = await SharedPrefsRepository.instance;
      final authStore = Modular.get<AuthStore>();
      var isLogged = await authStore.isLogged();
      if (!isLogged) {
        await Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      } else {
        await authStore.loaderUserModel();
        var prefs = await SharedPrefsRepository.instance;
        await Modular.get<UsuarioRepository>().updateToken(prefs.deviceToken);
        await Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
      }
    });
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *.5,
          height: MediaQuery.of(context).size.width *.5,
            child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
