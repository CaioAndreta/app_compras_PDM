import 'package:flutter/material.dart';
import 'package:projeto_tarefas/models/tarefa.model.dart';
import 'package:projeto_tarefas/repositories/tarefa.repository.dart';

class EditaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context, Tarefa tarefa) {
    print(tarefa);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.update(_tarefa, tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Tarefa"),
          actions: [
            FlatButton(
                onPressed: () => onSave(context, tarefa),
                child: Text('SALVAR', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  initialValue: tarefa.texto,
                  decoration: InputDecoration(
                      labelText: 'Nome', border: OutlineInputBorder()),
                  onSaved: (value) => _tarefa.texto = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo Obrigatório" : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: tarefa.qtde.toString(),
                  decoration: InputDecoration(
                      labelText: 'Quantidade', border: OutlineInputBorder()),
                  onSaved: (value) => _tarefa.qtde = int.parse(value),
                  validator: (value) =>
                      value.isEmpty ? "Campo Obrigatório" : null,
                )
              ])),
        ));
  }
}
