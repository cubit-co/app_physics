import 'package:app_physics/models/user_model.dart';
import 'package:app_physics/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthStorageKeys {
  static const USER = 'USER_DATA';
  static const LOGIN = 'IS_LOGIN';
  static const EMAIL = "EMAIL";
  static const TOKEN = "TOKEN";
}

class AuthService {
  static final _instance = AuthService._();

  // Instance to save persistent data
  SharedPreferences sharedPreferences;

  factory AuthService() {
    return _instance;
  }

  AuthService._();

  Future<String> login(email) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String device = sharedPreferences.getString(AuthStorageKeys.TOKEN);
    final response =
        await apiService.get('/login?email=' + email + '&device=' + device);
    await sharedPreferences.setString(AuthStorageKeys.EMAIL, email);
    return response.data['body'];
  }

  Future<String> register(email, phone, name, university, profession) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String device = sharedPreferences.getString(AuthStorageKeys.TOKEN);
    final response = await apiService.post('/register?device=' + device, data: {
      'email': email,
      'phone': phone,
      'name': name,
      'university': university,
      'profession': profession
    });
    await sharedPreferences.setString(AuthStorageKeys.EMAIL, email);
    return response.data['body'];
  }

  Future<User> getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String rawUser = sharedPreferences.getString(AuthStorageKeys.USER);
    User user;
    if (rawUser == null) {
      String email = sharedPreferences.getString(AuthStorageKeys.EMAIL);
      final response = await apiService.get('/get?email=' + email);
      user = User.fromJson(response.data['body']);
      await sharedPreferences.setString(
          AuthStorageKeys.USER, json.encode(user.toJson()));
    } else {
      user = User.fromJson(json.decode(rawUser));
    }
    return user;
  }

  Future<void> saveLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(AuthStorageKeys.LOGIN, "true");
  }

  Future<bool> isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final rawData = sharedPreferences.getString(AuthStorageKeys.LOGIN);
    if (rawData == null || rawData.isEmpty) return false;
    return true;
  }

  Future<void> clean() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(AuthStorageKeys.EMAIL);
    sharedPreferences.remove(AuthStorageKeys.LOGIN);
    sharedPreferences.remove(AuthStorageKeys.USER);
  }

  Future<void> saveDevice(String token) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(AuthStorageKeys.TOKEN, token);
  }
}
