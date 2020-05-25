import 'package:cuidapet/app/repositories/addresses_repository.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_store.dart';

class CuidapetDrawer extends Drawer {
  CuidapetDrawer()
      : super(
          child: Container(
            margin: EdgeInsets.only(top: 70),
            child: Column(
              children: <Widget>[
                Observer(
                  builder: (_) {
                    var user = Modular.get<AuthStore>().usuario;
                    return Column(children: <Widget>[
                      Container(
                        height: 200,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundImage: user.imgAvatar != null ? NetworkImage(user.imgAvatar) : null,
                                radius: 100,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () => Modular.to.pushNamed('/image_profile'),
                                  child: Text(
                                    'Alterar Imagem',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(user.email)
                    ]);
                  },
                ),
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
                        onTap: () => Modular.to.pushNamed('/chat_list'),
                        leading: Icon(Icons.chat),
                        title: Text('Chats'),
                      ),
                      ListTile(
                        onTap: () async {
                          Loader.show();
                          var prefs = await SharedPrefsRepository.instance;
                          prefs.logout();
                          Loader.hide();
                          await Modular.get<AdressesRepository>().clearDatabase();
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
