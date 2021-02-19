import 'package:app_physics/routes.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    verifySessionAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void verifySessionAndNavigate() async {
    final isLoggedIn = await authService.isLogin();

    Navigator.of(context)
        .popAndPushNamed(isLoggedIn ? RouteNames.HOME : RouteNames.LOGIN);
  }
}
