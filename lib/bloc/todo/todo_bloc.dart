import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo/todo_event.dart';
import 'package:todo_app/bloc/todo/todo_state.dart';
import 'package:todo_app/services/firestore_service.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {

  final FirestoreService _firestoreService;

  TodoBloc(this._firestoreService) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await _firestoreService.getTodos().first;
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos. ${e.toString()}'));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.addTodo(event.todo);
        emit(TodoOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(TodoError('Failed to add todo.'));
      }
    });

    on<UpdateTodo>((event, emit)  async {
      try {
        emit(TodoLoading());
        await _firestoreService.updateTodo(event.todo);
        emit(TodoOperationSuccess('Todo updated successfully.'));
      } catch (e) {
        emit(TodoError('Failed to update todo.'));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        emit(TodoLoading());
        await _firestoreService.deleteTodo(event.todoId);
        emit(TodoOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(TodoError('Failed to delete todo.'));
      }
    });

  }

}