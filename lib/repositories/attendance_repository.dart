import '../../utils/api_urls.dart';
import '../services/api_service.dart';

class AttendanceRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchStatus() async {
    try {
      final response = await _apiService.get(ApiUrls.status);
      return response is Map<String, dynamic> ? response : {};
    } catch (e) {
      throw Exception("Fetch status failed: $e");
    }
  }

  Future<Map<String, dynamic>> markAttendance(String status, double lat, double lng) async {
    try {
      final response = await _apiService.post(ApiUrls.mark, {
        "attendance_status": status, // e.g., 'in' or 'out'
        "latitude": lat.toString(),
        "longitude": lng.toString(),
      });
      return response;
    } catch (e) {
      throw Exception("Mark attendance failed: $e");
    }
  }

  Future<List<dynamic>> fetchRoutes() async {
    try {
      final response = await _apiService.get(ApiUrls.routeList);
      return response['routes'] ?? [];
    } catch (e) {
      return [];
    }
  }
}
