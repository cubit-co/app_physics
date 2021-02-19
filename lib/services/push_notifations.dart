import 'dart:async';
import 'package:app_physics/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  PushNotification._();

  factory PushNotification() => _instance;

  static final PushNotification _instance = PushNotification._();

  bool _initialized = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final authService = AuthService();
  final _streamNotification = StreamController<dynamic>.broadcast();
  Stream<dynamic> get message => _streamNotification.stream;

  void initNotifications() {
    if (!_initialized) {
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.getToken().then((String token) {
        authService.saveDevice(token);
      });
      _firebaseMessaging.configure(
        onMessage: (dynamic message) async {
          _streamNotification.sink.add(message);
        },
        onLaunch: (dynamic message) async {},
        onResume: (dynamic message) async {},
      );
      _initialized = true;
    }
  }

  void disponse() {
    _streamNotification?.close();
  }
}
