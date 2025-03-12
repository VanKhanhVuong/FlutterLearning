import 'package:flutter_auth_vk/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo_model.dart';

// Provider cho TodoService
final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService();
});

// Provider theo dõi danh sách todos từ Firestore
final todoProvider = StreamProvider.autoDispose<List<TodoModel>>((ref) {
  final todoService = ref.watch(todoServiceProvider);
  return todoService.getTodosStream();
});
