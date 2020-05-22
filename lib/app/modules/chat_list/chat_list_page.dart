import 'package:cuidapet/app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_list_controller.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends ModularState<ChatListPage, ChatListController> {
  //use 'controller' variable to access controller
  var status = {'A': 'Ativo', 'F': 'Finalizado'};

  @override
  void initState() {
    super.initState();
    controller.findChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Observer(builder: (_) {
        return FutureBuilder<List<ChatModel>>(
          future: controller.chatFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                var chats = snapshot.data;

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao buscar chats tente novamente mais tarde'));
                }

                if (chats.isEmpty) {
                  return Center(child: Text('Nenhum Chat Pendente'));
                }

                return RefreshIndicator(
                  onRefresh: () => Future.delayed(Duration.zero, () => controller.findChats()),
                  child: ListView.separated(
                    
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                    itemCount: chats.length,
                    itemBuilder: (_, index) {
                      final chat = chats[index];
                      print(chat);
                      return ListTile(
                        onTap: () => Modular.to.pushNamed('/chat_list/chat', arguments: chat),
                        contentPadding: EdgeInsets.all(5),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(chat.fornecedor.logo),
                        ),
                        title: Text(chat.fornecedor.nome),
                        subtitle: Text(chat.nomePet),
                      );
                    },
                  ),
                );
                break;
              default:
                return Container();
            }
          },
        );
      }),
    );
  }
}
