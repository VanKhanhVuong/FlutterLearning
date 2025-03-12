import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_model.dart';

class TodoService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Lấy danh sách todo theo dạng stream
  Stream<List<TodoModel>> getTodosStream() {
    return firestore.collection('todos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromJson(
            doc.data()); // Chuyển dữ liệu từ Firestore thành TodoModel
      }).toList();
    });
  }

  Future<void> addTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).set(todo.toJson());
  }

  Future<void> updateTodo(TodoModel todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}
