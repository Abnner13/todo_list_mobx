import 'package:mobx/mobx.dart';
part 'TodoItemStore.g.dart';

class TodoItemStore = _TodoItemStore with _$TodoItemStore;

abstract class _TodoItemStore with Store {
  _TodoItemStore(this.title);
  String title;

  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;
}
