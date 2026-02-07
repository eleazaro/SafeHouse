import 'package:flutter/foundation.dart';

import '../../../config/strings/app_strings.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _authRepository.isAuthenticated;
  User? get currentUser => _authRepository.currentUser;
  String? get error => _error;

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await _authRepository.signInWithGoogle();
      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      _error = AppStrings.loginError;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await _authRepository.signOut();

    _isLoading = false;
    notifyListeners();
  }
}
