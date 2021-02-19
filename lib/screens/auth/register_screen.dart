import 'package:app_physics/helpers/validators.dart';
import 'package:app_physics/routes.dart';
import 'package:app_physics/screens/auth/validate_screen.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Variables to manage form state
  String _email;
  String _name;
  String _phone;
  String _university;
  String _profession;

  // Form reference
  final _formKey = GlobalKey<FormState>();

  // Class services
  final authService = AuthService();

  // Form validations state
  bool _autoValidateForm = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    _email = args;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Text(
              'Registrate',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _activateAccountMessageText(),
            SizedBox(height: 30),
            _activateAccountForm(),
          ],
        ),
      ),
    );
  }

  Widget _activateAccountMessageText() {
    return Text(
      'Registrate y ten acceso exclusivo a todo el contenido del congreso!',
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Colors.black38,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _activateAccountForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Correo',
            ),
            initialValue: _email,
            enabled: false,
          ),
          SizedBox(height: 30),
          TextFormField(
            autovalidate: _autoValidateForm,
            decoration: InputDecoration(
              labelText: 'Nombre Completo',
            ),
            enabled: !_isLoading,
            validator: (value) {
              if (!Validators.required(value)) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            onChanged: (value) {
              _name = value.trim();
            },
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 30),
          TextFormField(
            enabled: !_isLoading,
            keyboardType: TextInputType.phone,
            autovalidate: _autoValidateForm,
            decoration: InputDecoration(
              labelText: 'Celular',
            ),
            validator: (value) {
              if (!Validators.required(value)) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            onChanged: (value) {
              _phone = value.trim();
            },
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 30),
          TextFormField(
            enabled: !_isLoading,
            autovalidate: _autoValidateForm,
            decoration: InputDecoration(
              labelText: 'Universidad',
            ),
            validator: (value) {
              if (!Validators.required(value)) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            onChanged: (value) {
              _university = value.trim();
            },
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 30),
          TextFormField(
            enabled: !_isLoading,
            autovalidate: _autoValidateForm,
            decoration: InputDecoration(
              labelText: 'Profesión',
            ),
            validator: (value) {
              if (!Validators.required(value)) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
            onChanged: (value) {
              _profession = value.trim();
            },
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (_) => _activateAccount(),
          ),
          SizedBox(height: 20),
          _activateAccountFormActions(),
        ],
      ),
    );
  }

  Widget _activateAccountFormActions() {
    final buttonColor = Theme.of(context).primaryColorDark;
    final textColor = Colors.white;

    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            child: Text('SALIR'),
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            color: buttonColor,
            textColor: textColor,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: RaisedButton(
            child: _isLoading
                ? Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : Text('CONTINUAR'),
            onPressed: _isLoading ? null : _activateAccount,
            color: buttonColor,
            textColor: textColor,
          ),
        ),
      ],
    );
  }

  void _activateAccount() async {
    final isValidForm = _formKey.currentState.validate();
    setState(() {
      _autoValidateForm = !isValidForm;
      _isLoading = isValidForm;
    });

    if (!isValidForm) return;
    try {
      final result = await authService.register(
          _email, _phone, _name, _university, _profession);
      setState(() {
        _isLoading = false;
      });
      if (result != null) {
        Navigator.of(context)
            .popAndPushNamed(RouteNames.VALIDATE, arguments: result);
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
