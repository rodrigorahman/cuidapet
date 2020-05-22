import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CuidapetDrawer extends Drawer {
  CuidapetDrawer()
      : super(
          child: Container(
            margin: EdgeInsets.only(top: 70),
            child: Column(
              children: <Widget>[
                FutureBuilder<SharedPrefsRepository>(
                    future: SharedPrefsRepository.instance,
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
                          var user = snapshot.data.userData;
                          return Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: user.imgAvatar != null ? NetworkImage(user.imgAvatar) : null,
                                radius: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(user.email)
                            ],
                          );
                          break;
                        default:
                          return Container();
                      }
                    }),
                Expanded(
                                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        onTap: () => Modular.to.pushNamed('/meus_agendamentos'),
                        leading: Icon(Icons.receipt),
                        title: Text('Meus agendamentos'),
                      ),
                       ListTile(
                        onTap: () => Modular.to.pushNamed('/meus_agendamentos'),
                        leading: Icon(Icons.chat),
                        title: Text('Chats'),
                      ),
                      ListTile(
                        onTap: () async {
                          Loader.show();
                          var prefs = await SharedPrefsRepository.instance;
                          prefs.logout();
                          Loader.hide();
                          await Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
}
