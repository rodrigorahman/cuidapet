import 'package:cuidapet/app/models/chat_firebase_model.dart';
import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;
  const ChatPage({Key key, @required this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.getChat(widget.chat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Finalizar Chat',
            icon: Icon(FontAwesome.sign_out),
            onPressed: () {  },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) {
                List<ChatFirebaseModel> data = controller.messages?.data;
                
                if(data == null) return SizedBox.shrink();
                
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    var msg = data[index];
                    if (msg.fornecedor != null) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(controller.chat.fornecedor.logo),
                          radius: 40,
                        ),
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          controller.chat.fornecedor.nome,
                          style: TextStyle(color: ThemeUtils.primaryColorDark),
                        ),
                        subtitle: Text(
                          msg.mensagem,
                          style: TextStyle(color: ThemeUtils.primaryColorDark),
                        ),
                      );
                    } else {
                      return ListTile(
                        trailing: CircleAvatar(),
                        title: Text(
                          controller.chat.nome,
                          textAlign: TextAlign.end,
                        ),
                        subtitle: Text(
                          msg.mensagem,
                          textAlign: TextAlign.end,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    backgroundColor: ThemeUtils.primaryColor,
                    minRadius: 25,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () => controller.messageController.text.isNotEmpty ? controller.sendMessage() : null,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
