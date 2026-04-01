import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_urls.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login(String mobileNumber, String password) async {
    try {
      final response = await _apiService.post(ApiUrls.login, {
        "mobile_number": mobileNumber,
        "password": password,
      });

      if (response != null && response['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response['token']);
        
        // Speculatively save user_id / employee_id if present
        if (response['user_id'] != null) {
          await prefs.setInt('user_id', response['user_id'] as int);
        } else if (response['user']?['id'] != null) {
          await prefs.setInt('user_id', response['user']['id'] as int);
        }
      }
      return response;
    } catch (e) {
      // For development purposes, if dummy url throws 
      throw Exception("Login failed: $e");
    }
  }

  Future<Map<String, dynamic>> createAccount(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(ApiUrls.createAccount, data);
      return response;
    } catch (e) {
      throw Exception("Account creation failed: $e");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }
}
