import 'package:flutter/material.dart';
import '../../repositories/attendance_repository.dart';

class RouteViewModel extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();
  bool _isLoading = false;

  List<dynamic> _routes = [];

  bool get isLoading => _isLoading;
  List<dynamic> get routes => _routes;

  void fetchRoutes() async {
    _isLoading = true;
    notifyListeners();
    try {
      _routes = await _repo.fetchRoutes();
      if (_routes.isEmpty) {
        _routes = [
          {"date": "23 Aug 2026", "in": "9:30", "out": "6:30"},
          {"date": "22 Aug 2026", "in": "9:30", "out": "6:30"},
          {"date": "21 Aug 2026", "in": "9:30", "out": "6:30"},
          {"date": "20 Aug 2026", "in": "9:30", "out": "6:30"},
          {"date": "19 Aug 2026", "in": "9:30", "out": "6:30"},
        ];
      }
    } catch (_) {}
    _isLoading = false;
    notifyListeners();
  }
}
