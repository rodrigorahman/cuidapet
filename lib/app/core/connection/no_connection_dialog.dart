import 'package:connectivity/connectivity.dart';
import 'package:cuidapet/app/core/connection/connection_check.dart';
import 'package:cuidapet/app/shared/loader_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NoConnectionDialog extends StatelessWidget {

  final Function onRefresh;

  const NoConnectionDialog({Key key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        margin: EdgeInsets.all(20),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              // width: 50.5,
              // height: 60.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20),
                      // width: 190,
                      child: Image.asset(
                        'assets/images/no_network.png',
                      )),
                  SizedBox(height: 30),
                  Text(
                    'Algo deu errado.',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Por favor verifique sua conexão', style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                              Navigator.of(context).pop();
                          // var connectivityResult = await (Connectivity().checkConnectivity());

                          // if (connectivityResult != ConnectivityResult.none) {
                          //   _noConnectionBloc.connectionRestored();
                          // }
                        },
                        child: Text('Tentar novamente', style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColorDark), textAlign: TextAlign.center)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
