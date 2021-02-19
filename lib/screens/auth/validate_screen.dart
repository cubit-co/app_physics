import 'package:app_physics/routes.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:flutter/material.dart';

class ValidateScreen extends StatefulWidget {
  ValidateScreen({Key key}) : super(key: key);

  @override
  _ValidateScreenState createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  String _code = '';
  bool _validCode = false;
  String _codeO = '';
  final authService = new AuthService();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _codeO = args;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: AlertDialog(
          title: Text('Verificación de cuenta'),
          titleTextStyle: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
          content: _alertContent(),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
              textColor: Theme.of(context).errorColor,
            ),
            FlatButton(
              onPressed: !_validCode ? null : _validateCode,
              child: Text('Aceptar'),
            ),
          ],
        ));
  }

  Widget _alertContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Escribe el código que fue enviado a tu correo.',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.0),
        TextField(
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          decoration: InputDecoration(
            labelText: 'Código',
          ),
          onChanged: (value) {
            setState(() {
              _code = value;
              _validCode = value.length == 4;
            });
          },
        ),
      ],
    );
  }

  void _validateCode() async {
    if (_code == _codeO) {
      await authService.saveLogin();
      Navigator.of(context).pop();
      Navigator.of(context).popAndPushNamed(RouteNames.HOME);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'El codigo ingresado es incorrecto',
              textAlign: TextAlign.center,
            ),
            actions: [
              FlatButton(
                onPressed: Navigator.of(context).pop,
                child: Text('Entendido'),
              )
            ],
          );
        },
      );
    }
  }
}
