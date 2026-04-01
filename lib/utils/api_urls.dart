class ApiUrls {
  static const String baseUrl = 'https://test.zyromate.com/api';

  // Auth endpoints
  static const String login = '$baseUrl/user-login';
  static const String createAccount = '$baseUrl/register';

  // Attendance endpoints
  static const String status = '$baseUrl/attendance/status';
  static const String mark = '$baseUrl/attendance/mark';
  static const String routeList = '$baseUrl/attendance/route-list';

  // Leave endpoints
  static const String applyLeave = '$baseUrl/apply-leave';
  static const String fetchLeaveList = '$baseUrl/leaves';
}
