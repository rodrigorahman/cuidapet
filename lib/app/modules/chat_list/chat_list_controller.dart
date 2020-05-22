import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/repositories/chat_repository.dart';
import 'package:mobx/mobx.dart';

part 'chat_list_controller.g.dart';

class ChatListController = _ChatListControllerBase with _$ChatListController;

abstract class _ChatListControllerBase with Store {
 
  _ChatListControllerBase(this._repository);

  final ChatRepository _repository;

  @observable
  ObservableFuture<List<ChatModel>> chatFuture;

  @action
  void findChats(){
    chatFuture = ObservableFuture(_repository.buscarChatsUsuario());
  }

}
