import 'package:app_physics/services/push_notifations.dart';
import 'package:app_physics/theme.dart';
import 'package:app_physics/widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:app_physics/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  void show(String title, String message) {
    final context = navigatorKey.currentState.overlay.context;
    final dialog = SwitchDialog(title: title, body: message);
    showDialog(context: context, builder: (x) => dialog);
  }

  @override
  void initState() {
    super.initState();
    final pushNotification = new PushNotification();
    pushNotification.initNotifications();
    pushNotification.message.listen((event) {
      dynamic notification = event['notification'] != null
          ? event['notification']
          : event['aps']['alert'];
      print(notification);
      show(notification['title'], notification['body']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Congreso de Física',
      navigatorKey: navigatorKey,
      routes: routes,
      initialRoute: INITIAL_ROUTE,
      theme: PhysicsTheme(context).themeData,
    );
  }
}
