import 'package:app_physics/helpers/validators.dart';
import 'package:app_physics/routes.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Form helpers
  bool _autoValidateForm = false;
  final _userIdFocusNode = FocusNode();

  // Form state
  String _email;

  //Loading attributes
  bool _isLoading = false;

  // Services
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_loginForm()],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0, 5),
                  spreadRadius: -5,
                ),
              ],
            ),
            child: _loginFormContent(),
          ),
        ],
      ),
    );
  }

  Widget _loginFormContent() {
    const CONTROLS_SPACING = 20.0;

    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: Image.asset(
          //     'assets/images/logos/app-logo.png',
          //     fit: BoxFit.contain,
          //   ),
          // ),
          SizedBox(height: CONTROLS_SPACING),
          TextFormField(
            validator: _emailValidator,
            autovalidate: _autoValidateForm,
            keyboardType: TextInputType.emailAddress,
            focusNode: _userIdFocusNode,
            textInputAction: TextInputAction.send,
            enabled: !_isLoading,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.account_circle),
            ),
            onChanged: (value) {
              _email = value;
            },
            onFieldSubmitted: (value) => _login(),
          ),
          SizedBox(height: CONTROLS_SPACING),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Colors.white,
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Text('INGRESAR'),
            ),
          ),
          SizedBox(height: CONTROLS_SPACING)
        ],
      ),
    );
  }

  // Login methods

  /// Validates user id [value] in the form
  String _emailValidator(String value) {
    if (!Validators.required(value)) {
      return '¡Este campo es obligatorio!';
    }

    if (!Validators.email(value)) {
      return 'El correo que ingresaste no es valido';
    }

    return null;
  }

  void _login() async {
    final isValidForm = _loginFormKey.currentState.validate();

    setState(() {
      _autoValidateForm = !isValidForm;
      _isLoading = isValidForm;
    });

    if (!isValidForm) return;

    bool loggedIn = false;

    try {
      await Future.delayed(Duration(seconds: 1));
      loggedIn = await authService.login(_email);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {}

    setState(() {
      _isLoading = false;
    });

    if (loggedIn) {
      Navigator.of(context).popAndPushNamed(RouteNames.HOME);
    }
  }
}
