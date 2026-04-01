import 'package:flutter/material.dart';
import '../../repositories/attendance_repository.dart';

class DashboardViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();
  bool _isLoading = false;

  // 0: Initial, 1: Marked In, 2: Marked Out (Completed)
  int _attendanceState = 0; 
  String _markInTime = "";
  String _markOutTime = "";

  List<dynamic> _recentActivity = [];

  bool get isLoading => _isLoading;
  int get attendanceState => _attendanceState;
  String get markInTime => _markInTime;
  String get markOutTime => _markOutTime;
  List<dynamic> get recentActivity => _recentActivity;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchDashboardData() async {
    _setLoading(true);
    try {
      final statusMap = await _repo.fetchStatus();
      if (statusMap['status'] == 'in') {
        _attendanceState = 1;
        _markInTime = statusMap['time'] ?? '';
      } else if (statusMap['status'] == 'out') {
        _attendanceState = 2;
        _markOutTime = statusMap['time'] ?? '';
      }
    } catch (_) { }
    _setLoading(false);
  }

  Future<void> markIn() async {
    _setLoading(true);
    try {
      await _repo.markAttendance('in', 0.0, 0.0);
      _attendanceState = 1;

      final now = DateTime.now();
      _markInTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      _attendanceState = 1;
      final now = DateTime.now();
      _markInTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
    }
    _setLoading(false);
  }

  Future<void> markOut() async {
    _setLoading(true);
    try {
      await _repo.markAttendance('out', 0.0, 0.0);
      _attendanceState = 2;

      final now = DateTime.now();
      _markOutTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      _attendanceState = 2;
      final now = DateTime.now();
      _markOutTime = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
    }
    _setLoading(false);
  }
}
