import 'package:flutter/material.dart';
import 'package:noteale_clone/models/notes_model.dart';
import 'package:noteale_clone/sqlite/database_helper.dart';

class NotesViewmodel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final List<NotesModel> _notes = [];
  String? _currentUserId;
  String _searchQuery = '';
  String? _selectedFilterColorHex; // null = no filter

  List<NotesModel> get notes => List.unmodifiable(_notes);
  String? get currentUserId => _currentUserId;

  /// Notes filtered by search query and optional color hex filter.
  List<NotesModel> get filteredNotes {
    final query = _searchQuery.trim().toLowerCase();
    final colorHex = _selectedFilterColorHex?.toLowerCase();

    Iterable<NotesModel> result = _notes;

    if (query.isNotEmpty) {
      result = result.where((n) => n.title.toLowerCase().contains(query));
    }

    if (colorHex != null) {
      result = result.where((n) => n.colorHex.toLowerCase() == colorHex);
    }

    return result.toList(growable: false);
  }

  String get searchQuery => _searchQuery;
  String? get selectedFilterColorHex => _selectedFilterColorHex;

  Future<void> loadNotesForUser(String userId) async {
    _currentUserId = userId;
    final items = await _dbHelper.getNotesForUser(userId);
    _notes
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterColor(String? colorHex) {
    _selectedFilterColorHex = colorHex;
    notifyListeners();
  }

  Future<void> addNote(NotesModel note) async {
    if (_currentUserId == null || note.userId != _currentUserId) {
      throw StateError('No user set for notes or mismatched user');
    }
    await _dbHelper.insertNote(note);
    _notes.add(note);
    notifyListeners();
  }

  NotesModel? getNoteById(String id) {
    try {
      return _notes.firstWhere((n) => n.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateNote(NotesModel updated) async {
    if (_currentUserId == null || updated.userId != _currentUserId) {
      throw StateError('No user set for notes or mismatched user');
    }
    await _dbHelper.updateNote(updated);
    final idx = _notes.indexWhere((n) => n.id == updated.id);
    if (idx != -1) {
      _notes[idx] = updated;
      notifyListeners();
    }
  }

  Future<void> removeNote(NotesModel note) async {
    await _dbHelper.deleteNote(note.id);
    _notes.removeWhere((n) => n.id == note.id);
    notifyListeners();
  }

  void clearNotes() {
    _notes.clear();
    _currentUserId = null;
    notifyListeners();
  }
}
