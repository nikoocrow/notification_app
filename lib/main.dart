import 'package:flutter/material.dart';
import 'package:notification_app/screens/home_screen.dart';
import 'package:notification_app/screens/message_screen.dart';
import 'package:notification_app/screens/services/push_notification_service.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationServices.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    //Context
    PushNotificationServices.messageStream.listen((message) {
          //print('My APP: $message');
          navigatorKey.currentState?.pushNamed('message', arguments: message);
          final snackBar = SnackBar(content: Text(message));
          messengerKey.currentState?.showSnackBar(snackBar);
     });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey, //Navegar
      scaffoldMessengerKey: messengerKey, //Snacks
      routes: {
        'home':(context) => HomeScreen(),
        'message':(context) => Messagecreen()
      },
    );
  }
}