import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseModel {
  
  int fornecedor;
  int usuario;
  String mensagem;

  ChatFirebaseModel.fromDoc(DocumentSnapshot doc) {
    fornecedor = doc['fornecedor'];
    usuario = doc['usuario'];
    mensagem = doc['mensagem'];
  }

}