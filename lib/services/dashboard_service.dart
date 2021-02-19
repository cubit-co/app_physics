import 'package:app_physics/services/api_service.dart';
import 'package:app_physics/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  static final _instance = DashboardService._();

  // Instance to save persistent data
  SharedPreferences sharedPreferences;

  factory DashboardService() {
    return _instance;
  }

  DashboardService._();

  Future<dynamic> getDashboard() async {
    final response = await apiService.get('/dashboard');
    return response.data['body'];
  }

  Future<void> saveAssitance(String id, String code) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String rawEmail = sharedPreferences.getString(AuthStorageKeys.EMAIL);
    await apiService.post('/dashboard/assitance',
        data: {'email': rawEmail, 'id': id, 'code': code});
  }
}
