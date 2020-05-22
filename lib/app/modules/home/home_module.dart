import 'package:cuidapet/app/modules/home/home_controller.dart';
import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/categories_repository.dart';
import 'package:cuidapet/app/repositories/fornecedor_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CategoriesRepository()),
        Bind(
          (i) => HomeController(
            i.get<AdressesRepository>(),
            i.get<CategoriesRepository>(),
            i.get<FornecedorRepository>()
          ),
        ),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
