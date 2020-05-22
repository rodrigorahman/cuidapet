import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_controller.dart';
import 'package:cuidapet/app/repositories/fornecedor_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/estabelecimento/estabelecimento_page.dart';

class EstabelecimentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EstabelecimentoController(i.get<FornecedorRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/:id', child: (_, args) => EstabelecimentoPage(id: int.parse(args.params['id'])))
      ];

  static Inject get to => Inject<EstabelecimentoModule>.of();
}
