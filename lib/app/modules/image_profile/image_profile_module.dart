import 'package:cuidapet/app/modules/image_profile/image_profile_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/image_profile/image_profile_page.dart';

class ImageProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ImageProfileController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ImageProfilePage()),
      ];

  static Inject get to => Inject<ImageProfileModule>.of();
}
