import 'dart:convert';
import 'dart:io';

import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FirebaseMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  Future<void> configure() async {

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project



    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('Chegou!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        print('onMessage: $message');
        var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
        var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
        var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

        await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
        var androidPlatformChannelSpecifics = AndroidNotificationDetails('br.com.programacaonapratica.cuidapet', 'cuidapet', 'cuidapet', importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//        _flutterLocalNotificationsPlugin.show(message['id'], 'me', body, notificationDetails)
        String payload;
        if(Platform.isIOS) {
          payload = message['payload'];
        }else{
          payload = message['data']['payload'];
        }
        
        await _flutterLocalNotificationsPlugin.show(
                0, message['notification']['title'],
                message['notification']['body'], platformChannelSpecifics,
                payload: payload);

        
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {

        print("onResume: $message");
      },
    );
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");

    });

    final sharedPrefs = await SharedPrefsRepository.instance;
    var token = await _fcm.getToken();
    print('token $token');
    sharedPrefs.registerDeviceToken(token);

  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {
    print(title);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    print('selectNotification');

  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
    print('nao tem notification payload: ');
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
