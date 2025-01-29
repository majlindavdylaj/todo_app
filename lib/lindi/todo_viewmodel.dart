import 'package:lindi/lindi.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/firestore_service.dart';

class TodoViewModel extends LindiViewModel<List<Todo>, String> {

  final FirestoreService _firestoreService;

  TodoViewModel(this._firestoreService);

  void loadTodo(bool loading) async {
    try {
      if(loading)setLoading();
      List<Todo> todos = await _firestoreService.getTodos().first;
      setData(todos);
    } catch (e) {
      setError('Failed to load todos. ${e.toString()}');
    }
  }

  void addTodo(Todo todo) async {
    try {
      await _firestoreService.addTodo(todo);
      loadTodo(false);
    } catch (e) {
      setError('Failed to add todo.');
    }
  }

  void updateTodo(Todo todo) async {
    try {
      await _firestoreService.updateTodo(todo);
      loadTodo(false);
    } catch (e) {
      setError('Failed to add todo.');
    }
  }

  void deleteTodo(todoId) async {
    try {
      await _firestoreService.deleteTodo(todoId);
      loadTodo(false);
    } catch (e) {
      setError('Failed to add todo.');
    }
  }

}