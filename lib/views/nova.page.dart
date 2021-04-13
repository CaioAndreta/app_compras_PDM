import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_tarefas/models/tarefa.model.dart';
import 'package:projeto_tarefas/repositories/tarefa.repository.dart';
import 'package:projeto_tarefas/models/tarefa.model.dart';

class NovaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _tarefa = Tarefa();
  final _repository = TarefaRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nova Tarefa"),
          actions: [
            FlatButton(
                onPressed: () => onSave(context),
                child: Text('SALVAR', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Nome', border: OutlineInputBorder()),
                  onSaved: (value) => _tarefa.texto = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo Obrigatório" : null,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Quantidade', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _tarefa.qtde = int.parse(value),
                  validator: (value) =>
                      value.isEmpty ? "Campo Obrigatório" : null,
                ),
              ])),
        ));
  }
}
