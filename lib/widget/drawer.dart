import 'package:app_physics/models/user_model.dart';
import 'package:app_physics/routes.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:flutter/material.dart';

class AccountDrawer extends StatefulWidget {
  @override
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  final authService = new AuthService();

  Future<User> getUser() async {
    final data = await authService.getUser();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
          future: getUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final user = snapshot.data;
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(user.name),
                    accountEmail: Text(user.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(user.name[0].toUpperCase()),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text('Cerrar sesión'),
                    onTap: () => _logOut(context),
                  )
                ],
              );
            }
          }),
    );
  }

  _logOut(BuildContext context) {
    authService.clean();
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, RouteNames.LOGIN);
  }
}
