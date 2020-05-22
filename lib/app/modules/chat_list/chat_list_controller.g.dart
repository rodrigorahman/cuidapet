// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatListController on _ChatListControllerBase, Store {
  final _$chatFutureAtom = Atom(name: '_ChatListControllerBase.chatFuture');

  @override
  ObservableFuture<List<ChatModel>> get chatFuture {
    _$chatFutureAtom.reportRead();
    return super.chatFuture;
  }

  @override
  set chatFuture(ObservableFuture<List<ChatModel>> value) {
    _$chatFutureAtom.reportWrite(value, super.chatFuture, () {
      super.chatFuture = value;
    });
  }

  final _$_ChatListControllerBaseActionController =
      ActionController(name: '_ChatListControllerBase');

  @override
  void findChats() {
    final _$actionInfo = _$_ChatListControllerBaseActionController.startAction(
        name: '_ChatListControllerBase.findChats');
    try {
      return super.findChats();
    } finally {
      _$_ChatListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatFuture: ${chatFuture}
    ''';
  }
}
