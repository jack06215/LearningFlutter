import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

var _uuid = const Uuid();

final sampleTodos = [];

class TodoNotifier extends StateNotifier<List<Todo>> {
  final Reader read;

  TodoNotifier(this.read, [List<Todo>? state]) : super(state ?? <Todo>[]);

  void add(String description) {
    state = [...state, Todo(description)];
  }

  void toggle(String id) {
    if (read(settingsProvider).deleteOnComplete) {
      remove(id);
      return;
    }

    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(todo.description, id: todo.id, completed: !todo.completed);
      }
      return todo;
    }).toList();
  }

  void edit({required String id, required String description}) {
    // List comprehension
    // https://dart.dev/guides/language/language-tour#collection-operators
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(description, id: todo.id, completed: todo.completed)
        else
          todo,
    ];
  }

  void remove(String id) {}
}

@immutable
class Todo {
  final String id;
  final String description;
  final bool completed;

  Todo(this.description, {this.completed = false, String? id})
      : id = id ?? _uuid.v4();
}

final settingsProvider = StateProvider<Settings>((ref) {
  return const Settings();
});

@immutable
class Settings {
  final bool deleteOnComplete;

  const Settings({this.deleteOnComplete = false});
}
