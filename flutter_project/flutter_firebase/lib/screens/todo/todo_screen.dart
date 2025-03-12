import 'package:flutter/material.dart';
import 'package:flutter_auth_vk/models/todo_model.dart';
import 'package:flutter_auth_vk/providers/todo_provider.dart';
import 'package:flutter_auth_vk/shared/styled_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListScreen extends HookWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final completedFilter = useState<bool?>(null);

    void showAddTaskDialog(BuildContext context, WidgetRef ref) {
      final titleController = TextEditingController();
      final subtitleController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final newTodo = TodoModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    subtitle: subtitleController.text,
                    isCompleted: false,
                  );

                  ref.read(todoServiceProvider).addTodo(newTodo);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      );
    }

    void confirmDelete(BuildContext context, WidgetRef ref, TodoModel todo) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm deletion ?"),
          content: Text("You sure you want to delete this ${todo.title} ?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ref.read(todoServiceProvider).deleteTodo(todo.id);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }

    void showEditTaskDialog(
        BuildContext context, WidgetRef ref, TodoModel todo) {
      final titleController = TextEditingController(text: todo.title);
      final subtitleController = TextEditingController(text: todo.subtitle);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Edit task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final updatedTodo = todo.copyWith(
                  title: titleController.text,
                  subtitle: subtitleController.text,
                );
                ref.read(todoServiceProvider).updateTodo(updatedTodo);
                Navigator.pop(context);
              },
              child: const Text("Save", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final todoState = ref.watch(todoProvider);

        return Scaffold(
          appBar: AppBar(
            title: const StyledAppBarText('Todo List'),
            backgroundColor: Colors.blue[500],
            centerTitle: true,
          ),
          body: todoState.when(
            data: (todos) {
              final filteredTodos = completedFilter.value == null
                  ? todos
                  : todos
                      .where(
                          (todo) => todo.isCompleted == completedFilter.value)
                      .toList();

              return ListView.builder(
                itemCount: filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = filteredTodos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.subtitle),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            ref.read(todoServiceProvider).updateTodo(
                                  todo.copyWith(isCompleted: value ?? false),
                                );
                          },
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              showEditTaskDialog(context, ref, todo),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmDelete(context, ref, todo),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showAddTaskDialog(context, ref),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
