import 'package:flutter/material.dart';
import 'package:noteale_clone/models/notes_model.dart';

class NotesViewmodel extends ChangeNotifier {
  final List<NotesModel> _notes = [];
  String _searchQuery = '';
  String? _selectedFilterColorHex; // null = no filter

  List<NotesModel> get notes => List.unmodifiable(_notes);

  /// Notes filtered by search query and optional color hex filter.
  List<NotesModel> get filteredNotes {
    final query = _searchQuery.trim().toLowerCase();
    final colorHex = _selectedFilterColorHex?.toLowerCase();

    Iterable<NotesModel> result = _notes;

    if (query.isNotEmpty) {
      result = result.where((n) => n.title.toLowerCase().contains(query));
    }

    if (colorHex != null) {
      result = result.where(
        (n) => (n.colorHex ?? '').toLowerCase() == colorHex,
      );
    }

    return result.toList(growable: false);
  }

  String get searchQuery => _searchQuery;
  String? get selectedFilterColorHex => _selectedFilterColorHex;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterColor(String? colorHex) {
    _selectedFilterColorHex = colorHex;
    notifyListeners();
  }

  void addNote(NotesModel note) {
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

  void updateNote(NotesModel updated) {
    final idx = _notes.indexWhere((n) => n.id == updated.id);
    if (idx != -1) {
      _notes[idx] = updated;
      notifyListeners();
    }
  }

  void removeNote(NotesModel note) {
    _notes.remove(note);
    notifyListeners();
  }
}
