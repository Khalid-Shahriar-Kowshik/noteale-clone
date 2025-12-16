import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:noteale_clone/models/user_model.dart';
import 'package:noteale_clone/sqlite/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  UserModel? _currentUser;
  String? _errorMessage;
  bool _isRestoringSession = true;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  static const _sessionKey = 'currentUserId';

  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;
  bool get isRestoringSession => _isRestoringSession;

  Future<void> restoreSession() async {
    _isRestoringSession = true;
    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getString(_sessionKey);
    if (storedId == null) {
      _isRestoringSession = false;
      notifyListeners();
      return;
    }

    final user = await _dbHelper.getUserById(storedId);
    if (user != null) {
      _currentUser = user;
    } else {
      await prefs.remove(_sessionKey);
    }

    _isRestoringSession = false;
    notifyListeners();
  }

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

    if (await _emailExists(normalizedEmail)) {
      _setError('An account with this email already exists');
      return false;
    }

    try {
      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: trimmedName,
        email: normalizedEmail,
        password: _hashPassword(password),
      );

      await _dbHelper.insertUser(newUser);
      _currentUser = newUser;
      await _persistSession(newUser.id);
      _isRestoringSession = false;
      notifyListeners();
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
      final foundUser = await _dbHelper.getUserByEmail(normalizedEmail);

      if (foundUser == null) {
        _setError('Invalid email or password');
        return false;
      }

      if (foundUser.password != _hashPassword(password)) {
        _setError('Invalid email or password');
        return false;
      }

      _currentUser = foundUser;
      await _persistSession(foundUser.id);
      _isRestoringSession = false;
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Login failed. Please try again.');
      return false;
    }
  }

  /// Log out the current user
  void logout() {
    _currentUser = null;
    _clearSession();
    _isRestoringSession = false;
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

  Future<bool> _emailExists(String email) async {
    final existing = await _dbHelper.getUserByEmail(email);
    return existing != null;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<void> _persistSession(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, userId);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
