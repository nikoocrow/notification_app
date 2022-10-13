// SHA1: 23:12:4C:CD:00:C5:13:DC:07:5E:07:5C:05:F0:8B:A3:9A:77:DE:45

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationServices{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;


  static Future<void> _backgroundMessage(RemoteMessage message) async{
         //print('onBackground Handler ${message.messageId}');
         print(message.data);
        //_messageStream.add(message.notification?.body ?? 'No hay Titulo');
        _messageStream.add(message.data['producto']?.body ?? 'No hay Data');

  }

    static Future<void> _onMessageHandler(RemoteMessage message) async{
         //print('onMessage Handler ${message.messageId}');
         print(message.data);
        //_messageStream.add(message.notification?.body ?? 'No hay Titulo');
       _messageStream.add(message.data['producto']?.body ?? 'No hay Data');

  }


    static Future<void> _onMessageOpenApp(RemoteMessage message) async{
         //print('onMessage Open App ${message.messageId}');
         print(message.data);
        _messageStream.add(message.data['producto']?.body ?? 'No hay Data');
        //_messageStream.add(message.notification?.body ?? 'No hay Titulo');


  }

    static Future initializeApp() async{
        //Push notification
        await Firebase.initializeApp();  
        token = await FirebaseMessaging.instance.getToken();
        print('Token: $token'); 

        //Handlers

        FirebaseMessaging.onBackgroundMessage(_backgroundMessage);
        FirebaseMessaging.onMessage.listen(_onMessageHandler);
        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
        //Local notification
    }


    static closeStreams(){
      _messageStream.close();
    }


}