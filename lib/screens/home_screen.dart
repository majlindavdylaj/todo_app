import 'package:flutter/material.dart';
import 'package:lindi/lindi.dart';
import 'package:todo_app/lindi/todo_viewmodel.dart';
import 'package:todo_app/models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TodoViewModel todoViewModel = LindiInjector.get<TodoViewModel>()..loadTodo(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore'),
      ),
      body: LindiBuilder(
        viewModel: todoViewModel,
        builder: (context) {
          if(todoViewModel.hasError){
            return Center(child: Text(todoViewModel.error!));
          }
          if(todoViewModel.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(todoViewModel.data!.isEmpty) {
            return const Center(child: Text('Empty List'));
          }
          return ListView.builder(
            itemCount: todoViewModel.data!.length,
            itemBuilder: (context, index) {
              final todo = todoViewModel.data![index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (value) {
                    final updatedTodo = todo.copyWith(completed: value);
                    todoViewModel.updateTodo(updatedTodo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    todoViewModel.deleteTodo(todo.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void _showAddTodoDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const  Text('Add Todo'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Todo title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Todo description'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final todo = Todo(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  completed: false,
                );
                todoViewModel.addTodo(todo);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
