import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageKeys {
  static const USER = 'USER_DATA';
}

class AuthService {
  static final _instance = AuthService._();

  // Instance to save persistent data
  SharedPreferences sharedPreferences;

  factory AuthService() {
    return _instance;
  }

  AuthService._();

  Future<bool> login(email) async {
    await sharedPreferences.setString(
      AuthStorageKeys.USER,
      "DATOS USUARIO MOCK",
    );
    return false;
  }

  Future<bool> isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final rawData = sharedPreferences.getString(AuthStorageKeys.USER);
    if (rawData == null || rawData.isEmpty) return false;
    return true;
  }
}
