class NotesModel {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String colorHex;
  final DateTime createdAt;

  NotesModel({
    String? id,
    required this.userId,
    required this.title,
    required this.content,
    required this.colorHex,
    required this.createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  NotesModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? colorHex,
    DateTime? createdAt,
  }) {
    return NotesModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'color_hex': colorHex,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      colorHex: map['color_hex'] as String? ?? '#FFFFFF',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (map['created_at'] as int?) ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
