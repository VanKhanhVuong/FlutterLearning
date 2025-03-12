import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String id;
  String title;
  String subtitle;
  bool isCompleted;
  DateTime? dueDate;

  TodoModel({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.dueDate,
  });

  // 🛠️ Thêm copyWith()
  TodoModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isCompleted': isCompleted,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      isCompleted: json['isCompleted'] ?? false,
      dueDate: json['dueDate'] != null
          ? (json['dueDate'] is Timestamp)
              ? json['dueDate'].toDate()
              : DateTime.parse(json['dueDate'])
          : null,
    );
  }
}
