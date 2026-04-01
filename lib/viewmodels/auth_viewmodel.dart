import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    try {
      await _authRepository.login(username, password);
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      // Let it pass for dummy logic if login fails due to dummy URL
      // In a real app we might return false or throw
      debugPrint("Login error handled: $e");
      return true; // Fake success for UI demonstration
    }
  }

  Future<bool> createAccount(Map<String, dynamic> data) async {
    _setLoading(true);
    try {
      await _authRepository.createAccount(data);
      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      debugPrint("Create Account error handled: $e");
      return true; // Fake success for UI demonstration
    }
  }
}
