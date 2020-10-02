import 'package:app_physics/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_physics/routes.dart';

void main() {
  runApp(PhysicsApp());
}

class PhysicsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Congreso de Física',
      routes: routes,
      initialRoute: INITIAL_ROUTE,
      theme: PhysicsTheme(context).themeData,
    );
  }
}
