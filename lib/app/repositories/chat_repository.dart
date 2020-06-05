import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/chat_firebase_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final Firestore _firestore = Firestore.instance;

  Future<List<ChatModel>> buscarChatsUsuario() {
    return CustomDio.authInstance.get('/chats/usuario').then(
          (res) => res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList(),
        );
  }

  Stream<List<ChatFirebaseModel>> getMessages(ChatModel chat) {
    return _firestore.collection('chat').document(chat.id.toString())
      .collection('messages')
      .orderBy('data_mensagem', descending: false).snapshots().map((query) => query.documents.map((m) => ChatFirebaseModel.fromDoc(m)).toList());
  }

  Future<void> sendMessage(int chat, String mensagem, int usuario) async {
    var data = <String, dynamic>{'mensagem': mensagem, 'data_mensagem': DateTime.now(), 'usuario': usuario};

    _firestore.collection('chat').document(chat.toString()).collection('messages').add(data);
    await CustomDio.authInstance.post('/chats/notificar', data: {
      'chat': chat,
      'mensagem': mensagem,
      'para': 'F',
    });
  }

  Future<List<ChatModel>> closeChat(ChatModel chat) {
    return CustomDio.authInstance.get('/chats/close/${chat.id}').then(
          (res) => res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList(),
        );
  }
}
