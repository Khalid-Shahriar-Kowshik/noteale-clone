import 'package:flutter/material.dart';
import 'package:noteale_clone/models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  UserModel? _currentUser;
  String? _errorMessage;

  final List<UserModel> _registeredUsers = [];

  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    clearError();

    final trimmedName = name.trim();
    final normalizedEmail = email.trim().toLowerCase();

    if (!_validateRegistrationInput(
      trimmedName: trimmedName,
      email: normalizedEmail,
      password: password,
      confirmPassword: confirmPassword,
    )) {
      return false;
    }

    if (_emailExists(normalizedEmail)) {
      _setError('An account with this email already exists');
      return false;
    }

    try {
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: trimmedName,
        email: normalizedEmail,
        password: password,
      );

      _registeredUsers.add(newUser);
      _currentUser = newUser;
      return true;
    } catch (e) {
      _setError('Failed to create account. Please try again.');
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    clearError();

    final normalizedEmail = email.trim().toLowerCase();

    if (!_validateLoginInput(email: normalizedEmail, password: password)) {
      return false;
    }

    try {
      UserModel? foundUser;

      for (final user in _registeredUsers) {
        final sameEmail = user.email.toLowerCase() == normalizedEmail;
        final samePassword = user.password == password;

        if (sameEmail && samePassword) {
          foundUser = user;
          break;
        }
      }

      if (foundUser == null) {
        _setError('Invalid email or password');
        return false;
      }

      _currentUser = foundUser;
      return true;
    } catch (e) {
      _setError('Login failed. Please try again.');
      return false;
    }
  }

  /// Log out the current user
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

// idk
  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email);
  }

  bool _validateRegistrationInput({
    required String trimmedName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (trimmedName.isEmpty) {
      _setError('Name is required');
      return false;
    }
    if (email.isEmpty) {
      _setError('Email is required');
      return false;
    }
    if (!_isValidEmail(email)) {
      _setError('Please enter a valid email');
      return false;
    }
    if (password.isEmpty) {
      _setError('Password is required');
      return false;
    }
    if (password.length < 6) {
      _setError('Password must be at least 6 characters');
      return false;
    }
    if (password != confirmPassword) {
      _setError('Passwords do not match');
      return false;
    }

    return true;
  }

  bool _validateLoginInput({required String email, required String password}) {
    if (email.isEmpty) {
      _setError('Email is required');
      return false;
    }
    if (password.isEmpty) {
      _setError('Password is required');
      return false;
    }
    return true;
  }

  bool _emailExists(String email) {
    for (final user in _registeredUsers) {
      if (user.email.toLowerCase() == email.toLowerCase()) {
        return true;
      }
    }
    return false;
  }
}
