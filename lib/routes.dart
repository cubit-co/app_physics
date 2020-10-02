import 'package:app_physics/screens/auth/login_screen.dart';
import 'package:app_physics/screens/home/home_screen.dart';
import 'package:app_physics/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const LOGIN = '/auth/login';
  static const HOME = '/home';
  static const SPLASH = '/splash';
}

final Map<String, WidgetBuilder> routes = {
  RouteNames.LOGIN: (context) => LoginScreen(),
  RouteNames.HOME: (context) => HomeScreen(),
  RouteNames.SPLASH: (context) => SplashScreen(),
};

const INITIAL_ROUTE = RouteNames.SPLASH;
