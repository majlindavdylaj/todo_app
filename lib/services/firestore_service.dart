import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';

class FirestoreService {

  final CollectionReference _todosCollection =
  FirebaseFirestore.instance.collection('todos');

  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Todo(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          completed: data['completed']
        );
      }).toList();
    });
  }

  Future<void> addTodo(Todo todo) async {
    await _todosCollection.add(todo.toJson());
  }

  Future<void> updateTodo(Todo todo) async {
    await _todosCollection.doc(todo.id).update(todo.toJson());
  }

  Future<void> deleteTodo(String todoId) async {
    await _todosCollection.doc(todoId).delete();
  }

}