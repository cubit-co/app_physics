import 'package:app_physics/screens/auth/login_screen.dart';
import 'package:app_physics/screens/auth/register_screen.dart';
import 'package:app_physics/screens/auth/validate_screen.dart';
import 'package:app_physics/screens/home/assistance_screen.dart';
import 'package:app_physics/screens/home/home_screen.dart';
import 'package:app_physics/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteNames {
  static const LOGIN = '/auth/login';
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const REGISTER = '/register';
  static const VALIDATE = '/validate';
  static const ASSITANCE = '/assitance';
}

final Map<String, WidgetBuilder> routes = {
  RouteNames.LOGIN: (context) => LoginScreen(),
  RouteNames.HOME: (context) => HomeScreen(),
  RouteNames.SPLASH: (context) => SplashScreen(),
  RouteNames.REGISTER: (context) => RegisterScreen(),
  RouteNames.VALIDATE: (context) => ValidateScreen(),
  RouteNames.ASSITANCE: (context) => AssitanceScreen(),
};

const INITIAL_ROUTE = RouteNames.SPLASH;
