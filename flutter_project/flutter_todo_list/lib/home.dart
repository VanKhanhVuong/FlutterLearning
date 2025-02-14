import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todo.dart';
import 'package:flutter_todo_list/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _fromGlobalKey = GlobalKey<FormState>();

  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  final List<Todo> todos = [
    const Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    const Todo(
        title: 'Make the bed',
        description: 'Keep things tidy please..',
        priority: Priority.low),
    const Todo(
        title: 'Pay bills',
        description: 'The gas bill needs paying ASAP.',
        priority: Priority.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),

            // form stuff below here
            Form(
                key: _fromGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Todo Title
                    TextFormField(
                      maxLength: 20,
                      decoration: const InputDecoration(
                        label: Text('Todo title'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must enter a value for the title.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _title = newValue!;
                      },
                    ),

                    // Todo description
                    TextFormField(
                      maxLength: 40,
                      decoration: const InputDecoration(
                        label: Text('Todo description'),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'Enter a description at least 5 chars long.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _description = newValue!;
                      },
                    ),

                    // Priority
                    DropdownButtonFormField(
                      value: _selectedPriority,
                      decoration: const InputDecoration(
                        label: Text('Priority of todo'),
                      ),
                      items: Priority.values.map((p) {
                        return DropdownMenuItem(
                          value: p,
                          child: Text(p.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),

                    // Summit Button
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: () {
                        if (_fromGlobalKey.currentState!.validate()) {
                          _fromGlobalKey.currentState!.save();
                          setState(() {
                            todos.add(Todo(
                                title: _title,
                                description: _description,
                                priority: _selectedPriority));
                          });
                          _fromGlobalKey.currentState!.reset();
                          _selectedPriority = Priority.low;
                        }
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                      child: const Text('Add'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
