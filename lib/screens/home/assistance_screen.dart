import 'package:app_physics/services/dashboard_service.dart';
import 'package:flutter/material.dart';

class AssitanceScreen extends StatefulWidget {
  AssitanceScreen({Key key}) : super(key: key);

  @override
  _AssitanceScreenState createState() => _AssitanceScreenState();
}

class _AssitanceScreenState extends State<AssitanceScreen> {
  String _id = '';
  bool _validCode = false;
  String code = '';
  final dashboardService = new DashboardService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _id = args;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: AlertDialog(
          title: Text('Verificación de asistencia'),
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
          'Escribe el código que fue presentado durante el evento.',
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
              code = value;
              _validCode = value.length == 4;
            });
          },
        ),
      ],
    );
  }

  void _validateCode() async {
    try {
      await dashboardService.saveAssitance(_id, code);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}
