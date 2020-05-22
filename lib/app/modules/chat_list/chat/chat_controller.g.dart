// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$chatAtom = Atom(name: '_ChatControllerBase.chat');

  @override
  ChatModel get chat {
    _$chatAtom.reportRead();
    return super.chat;
  }

  @override
  set chat(ChatModel value) {
    _$chatAtom.reportWrite(value, super.chat, () {
      super.chat = value;
    });
  }

  final _$messagesAtom = Atom(name: '_ChatControllerBase.messages');

  @override
  ObservableStream<List<ChatFirebaseModel>> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableStream<List<ChatFirebaseModel>> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$getChatAsyncAction = AsyncAction('_ChatControllerBase.getChat');

  @override
  Future<void> getChat(ChatModel chat) {
    return _$getChatAsyncAction.run(() => super.getChat(chat));
  }

  @override
  String toString() {
    return '''
chat: ${chat},
messages: ${messages}
    ''';
  }
}
