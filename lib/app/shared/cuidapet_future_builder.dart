import 'package:cuidapet/app/core/connection/no_connection_dialog.dart';
import 'package:cuidapet/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CuidapetFutureBuilder<T> extends FutureBuilder<T> {
  CuidapetFutureBuilder({
    Future<T> future,
    AsyncWidgetBuilder errorBuilder,
    AsyncWidgetBuilder successBuilder,
    Function onRefresh,
    String mensagemNone,
  }) : super(
            future: future,
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                  return Text(
                    mensagemNone ?? '',
                    textAlign: TextAlign.center,
                  );
                  break;
                case ConnectionState.waiting:
                  return Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError && snapshot.error.runtimeType == ConnectionError) {
                    // Future.delayed(Duration.zero, () => Modular.to.pushNamed('/error').then((_) => onRefresh()));
                    
                    return Container();
                  } else if (snapshot.hasError) {
                    return errorBuilder(_,snapshot) ?? Container();
                  } else {
                    return successBuilder(_, snapshot);
                  }
                  break;
                default:
                  return Container();
              }
            });
}
