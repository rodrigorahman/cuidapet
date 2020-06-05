import 'dart:convert';
import 'dart:io';

import 'package:cuidapet/app/models/chat_model.dart';
import 'package:cuidapet/app/modules/chat_list/chat/chat_controller.dart';
import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class FirebaseMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  Future<void> configure() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('br.com.programacaonapratica.cuidapet', 'cuidapet', 'cuidapet', importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          try {
            print('Chegou!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            print('onMessage: $message');

//        _flutterLocalNotificationsPlugin.show(message['id'], 'me', body, notificationDetails)
            String payload;
            if (Platform.isIOS) {
              payload = message['payload'];
            } else {
              payload = message['data']['payload'];
            }

            var showMessage = true;

            try {
              var chatController = Modular.get<ChatController>();

              print('############################################################ CHAT');
              if (chatController != null) {
                var payloadData = json.decode(payload);
                if (payloadData['type'] == 'CHAT_MESSAGE' && payloadData['chat']['id'] == chatController.chat.id) {
                  showMessage = false;
                }
              }
            } on ModularError catch (e) {
              // Só foi colocar esse try porque o modular retorna erro caso ele nao encontre o objeto
              showMessage = true;
            }

            if (showMessage) {
              await _flutterLocalNotificationsPlugin.show(99, message['notification']['title'], message['notification']['body'], platformChannelSpecifics, payload: payload);
            }
          } catch (e) {
            print(e);
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
        },
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');
        },
        onBackgroundMessage: myBackgroundMessageHandler);
    _fcm.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print('Settings registered: $settings');
    });

    final sharedPrefs = await SharedPrefsRepository.instance;
    var token = await _fcm.getToken();
    print('token $token');
    sharedPrefs.registerDeviceToken(token);
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {
    print(title);
  }

  Future onSelectNotification(String payload) async {
    var chatController;

    try {
      if (payload != null) {
        print('notification payload: ' + payload);
        var data = json.decode(payload);
        if (data['type'] == 'CHAT_MESSAGE') {
          var goToChat = true;
          final chatModel = ChatModel.fromJson(data['chat']);
          try {
            chatController = Modular.get<ChatController>();
            if (chatController.chat.id == chatModel.id) {
              goToChat = false;
            }
          } catch (e) {}

          if (goToChat) {
            Future.delayed(Duration.zero, () => Modular.to.pushNamed('/chat_list/chat/', arguments: chatModel));
          }

          // Modular.to.pushNamed('/chat_list/chat/', arguments: int.parse(data['chat']));
        }
      }
      print('selectNotification');
    } catch (e) {
      print(e);
    }
  }

}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }
  print('myBackgroundMessageHandler');

  // Or do other work.
}
