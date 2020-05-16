import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CuidapetDrawer extends Drawer {
  CuidapetDrawer()
      : super(
          child: Container(
            margin: EdgeInsets.only(top: 70),
            child: Column(
              children: <Widget>[
                CircleAvatar(minRadius: 70,),
                SizedBox(height: 10,),
                Text('Rodrigo Rahman'),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.receipt),
                      title: Text('Minhas solicitações'),
                    ),
                    ListTile(
                      onTap: () async {
                        Loader.show();
                        var prefs = await SharedPrefsRepository.instance;
                        prefs.logout();
                        Loader.hide();
                        Get.offAllNamed('/');
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sair'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
}
