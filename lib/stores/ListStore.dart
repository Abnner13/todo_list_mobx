import 'package:todo_mobx/stores/TodoItemStore.dart';
import 'package:mobx/mobx.dart';
part 'ListStore.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newTodoTitle = '';

  ObservableList<TodoItemStore> todoList = ObservableList<TodoItemStore>();

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TodoItemStore(newTodoTitle));
    newTodoTitle = '';
  }

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;
}
