import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_challenger/app/modules/home/models/todo_model.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Observer(builder: (_) {
        if (controller.todoList!.hasError) {
          return Center(
            child: ElevatedButton(
              child: Text('Button'),
              onPressed: () {
                controller.getList;
              },
            ),
          );
        }

        if (controller.todoList!.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<TodoModel> list = controller.todoList!.data;

        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              var todo = list[i];
              return ListTile(
                onTap: () {
                  _showDialog(todo);
                },
                title: Text(todo.title),
                leading: IconButton(
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    todo.delete();
                  },
                ),
                trailing: Checkbox(
                  onChanged: (value) {
                    todo.check = value!;
                    todo.save();
                  },
                  value: todo.check,
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _showDialog([TodoModel? model]) {
    model ??= TodoModel();
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: model!.title != '' ? Text('Edite') : Text('Adicionar novo'),
          content: TextFormField(
            initialValue: model.title,
            onChanged: (value) => model!.title = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: model.title != '' ? 'Edição...' : 'Escreva...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await model!.save();
                Modular.to.pop();
              },
              child: Text('Salvar'),
            )
          ],
        );
      },
    );
  }
}
