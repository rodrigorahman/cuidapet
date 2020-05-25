import 'dart:convert';

import 'package:cuidapet/app/core/dio/custom_dio.dart';
import 'package:cuidapet/app/models/facebook_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookRepository {
  Future<FacebookModel> login() async {
    var facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['public_profile', 'email']);

    print(result.status);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        var token = result.accessToken.token;

        var firebaseAuth = FirebaseAuth.instance;
        final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: token);
        await firebaseAuth.signInWithCredential(facebookAuthCred);

        var rest = CustomDio.instance;
        var graphResponse = await rest.get('https://graph.facebook.com/v4.0/me?fields=birthday,name,first_name,last_name,email,picture,link&access_token=$token');
        var model = FacebookModel.fromJson(json.decode(graphResponse.data));
        model.largePicture = 'https://graph.facebook.com/${model.id}/picture?type=large';
        return model;
        break;
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        if (result.errorMessage.contains('different Facebook user')) {
          await facebookLogin.logOut();
          return login();
        } else {
          throw Exception(result.errorMessage);
        }
        break;
      default:
        return null;
    }
  }
}
