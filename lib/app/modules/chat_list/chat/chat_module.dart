import 'package:cuidapet/app/modules/chat_list/chat/chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet/app/modules/chat_list/chat/chat_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ChatPage(chat: args.data,)),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
