import 'package:cuidapet/app/models/chat_firebase_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/repositories/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  
  _ChatControllerBase(this._repository);
  
  final ChatRepository _repository;
  final TextEditingController messageController = TextEditingController();
  
  @observable
  ChatModel chat; 

  @observable
  ObservableStream<List<ChatFirebaseModel>> messages;

  @action
  Future<void> getChat(ChatModel chat) async {
    this.chat = chat;
    var m = _repository.getMessages(chat);
    messages = m.asObservable();
  }

  void sendMessage() {
    _repository.sendMessage(chat.id, messageController.text, chat.usuario); 
    messageController.text = '';
  }

  Future<void> closeChat() async {
    await _repository.closeChat(chat);
    Modular.to.pop();
  }

}
