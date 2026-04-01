import '../../utils/api_urls.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LeaveRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> applyLeave(Map<String, dynamic> data) async {
    try {
      // Inject user_id from prefs if not provided
      if (!data.containsKey('user_id')) {
        final prefs = await SharedPreferences.getInstance();
        data['user_id'] = prefs.getInt('user_id') ?? 1;
      }
      final response = await _apiService.post(ApiUrls.applyLeave, data);
      return response;
    } catch (e) {
      throw Exception("Leave application failed: $e");
    }
  }

  Future<List<dynamic>> fetchLeaveList(String leaveType, String month) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final empId = prefs.getInt('user_id') ?? 1;
      final response = await _apiService.post(ApiUrls.fetchLeaveList, {
         "employee_id": empId,
         "leave_type": leaveType, // all, pending, approved, rejected
         "month": month
      });
      
      return response['leaves'] ?? [];
    } catch (e) {
      return [];
    }
  }
}
