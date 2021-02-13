import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/stores/ListStore.dart';
import 'package:todo_mobx/stores/LoginStore.dart';
import 'package:todo_mobx/widgets/CustomIconButton.dart';
import 'package:todo_mobx/widgets/CustomTextField.dart';

import 'LoginScreen.dart';

class ListScreen extends StatelessWidget {
  final listStore = ListStore();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.white,
                      onPressed: () {
                        Provider.of<LoginStore>(context, listen: false)
                            .logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Observer(
                          builder: (_) {
                            return CustomTextField(
                              controller: controller,
                              hint: 'Tarefa',
                              onChanged: listStore.setNewTodoTitle,
                              suffix: listStore.isFormValid
                                  ? CustomIconButton(
                                      radius: 32,
                                      iconData: Icons.add,
                                      onTap: () {
                                        listStore.addTodo();
                                        controller.clear();
                                      },
                                    )
                                  : null,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Observer(
                            builder: (_) {
                              return ListView.separated(
                                itemCount: listStore.todoList.length,
                                itemBuilder: (_, index) {
                                  final todoList = listStore.todoList[index];
                                  return Observer(
                                    builder: (_) {
                                      return ListTile(
                                        title: Text(
                                          todoList.title,
                                          style: TextStyle(
                                            decoration: todoList.done
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: todoList.done
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        ),
                                        onTap: todoList.toggleDone,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (_, __) {
                                  return Divider();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
