import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Note extends ChangeNotifier {
  final String _id;
  String title;
  String description;

  static Uuid get uuid => const Uuid();

  String get id => _id;

  Note({
    String? id,
    required this.title,
    required this.description,
  }) : _id = id ?? uuid.v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          runtimeType == other.runtimeType &&
          _id == other.id &&
          title == other.title &&
          description == other.description);

  @override
  int get hashCode => _id.hashCode ^ title.hashCode ^ description.hashCode;

  @override
  String toString() =>
      'Note{id: $_id, title: $title, description: $description}';

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'title': title,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) {
    return Note.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
