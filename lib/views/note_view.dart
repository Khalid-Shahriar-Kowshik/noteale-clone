import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteale_clone/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:noteale_clone/viewmodels/notes_viewmodel.dart';
import 'package:noteale_clone/models/notes_model.dart';

class NoteView extends StatefulWidget {
  final String? noteId;
  const NoteView({super.key, this.noteId});

  @override
  State<NoteView> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<NoteView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedColorHex = '#FFFFFF';
  bool _isExisting = false;
  bool _isEditing = true; // new note: editing by default
  NotesModel? _existingNote;
  bool _didLoad = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorsUtil.secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          _isExisting
              ? (_existingNote?.title.isEmpty ?? true
                    ? 'View Note'
                    : _existingNote!.title)
              : 'Add Note',
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          if (_isExisting)
            IconButton(
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (_isEditing) {
                    // Save changes
                    final updated = NotesModel(
                      id: _existingNote!.id,
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      colorHex: _selectedColorHex,
                      createdAt: _existingNote!.createdAt,
                    );
                    Provider.of<NotesViewmodel>(
                      context,
                      listen: false,
                    ).updateNote(updated);
                    _existingNote = updated;
                    _isEditing = false;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Note saved')));
                  } else {
                    _isEditing = true;
                  }
                });
              },
            ),
          if (_isExisting)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                if (_existingNote != null) {
                  Provider.of<NotesViewmodel>(
                    context,
                    listen: false,
                  ).removeNote(_existingNote!);
                  GoRouter.of(context).pop();
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Consumer<NotesViewmodel>(
              builder: (context, notesVM, _) {
                return ElevatedButton(
                  onPressed: () {
                    final title = _titleController.text.trim();
                    final content = _contentController.text.trim();

                    if (title.isEmpty && content.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please add a title or content before saving.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (_isExisting) {
                      // update existing note in-place
                      final updated = NotesModel(
                        id: _existingNote!.id,
                        title: title,
                        content: content,
                        colorHex: _selectedColorHex, // use chosen color
                        createdAt: _existingNote!.createdAt,
                      );
                      notesVM.updateNote(updated);
                      setState(() {
                        _existingNote = updated;
                        _isEditing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note saved')),
                      );
                    } else {
                      final newNote = NotesModel(
                        title: title,
                        content: content,
                        colorHex: _selectedColorHex, // use chosen color
                        createdAt: DateTime.now(),
                      );
                      notesVM.addNote(newNote);
                      GoRouter.of(context).pop();
                    }
                  },
                  child: Text(_isExisting ? 'Save Changes' : 'Save Note'),
                );
              },
            ),
            const SizedBox(height: 12),
            // Color picker
            Row(
              children: [
                const Text('Color:'),
                const SizedBox(width: 8),
                _buildColorOption('#FFFFFF'),
                const SizedBox(width: 8),
                _buildColorOption('#FFCDD2'),
                const SizedBox(width: 8),
                _buildColorOption('#C8E6C9'),
                const SizedBox(width: 8),
                _buildColorOption('#FFF9C4'),
              ],
            ),
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              maxLines: null,
              readOnly: _isExisting && !_isEditing,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Type Something...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                readOnly: _isExisting && !_isEditing,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(String hex) {
    final color = ColorsUtil.fromHex(hex);
    final isSelected = _selectedColorHex.toLowerCase() == hex.toLowerCase();

    return GestureDetector(
      onTap: () {
        if (_isExisting && !_isEditing) return;
        setState(() => _selectedColorHex = hex);
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.black, width: 2)
              : Border.all(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didLoad && widget.noteId != null) {
      final vm = Provider.of<NotesViewmodel>(context, listen: false);
      final note = vm.getNoteById(widget.noteId!);
      if (note != null) {
        _existingNote = note;
        _isExisting = true;
        _isEditing = true; // start editable per user request
        _titleController.text = note.title;
        _contentController.text = note.content;
        _selectedColorHex = note.colorHex;
      }
      _didLoad = true;
    }
  }
}
