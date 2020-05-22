import 'package:cuidapet/app/modules/login/cadastro/cadastro_module.dart';
import 'package:cuidapet/app/modules/login/change_password_modal/change_password_modal_controller.dart';
import 'package:cuidapet/app/modules/login/login_controller.dart';
import 'package:cuidapet/app/modules/login/login_reactions.dart';
import 'package:cuidapet/app/repositories/usuario_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/login/login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChangePasswordModalController(i.get<UsuarioRepository>())),
        Bind((i) => LoginController(i.get())),
        Bind((i) => LoginReactions(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
        Router('/cadastro', module: CadastroModule()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
