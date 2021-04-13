import 'package:flutter/material.dart';
import 'package:projeto_tarefas/models/tarefa.model.dart';
import 'package:projeto_tarefas/repositories/tarefa.repository.dart';
import 'package:projeto_tarefas/views/nova.page.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repository = TarefaRepository();

  List<Tarefa> tarefas;

  @override
  initState() {
    super.initState();
    this.tarefas = repository.read();
  }

  void ordenarLista() {
    tarefas.sort((a, b) => a.finalizada ? 1 : -1);
  }

  Future adicionarTarefa(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if (result != null && result == true) {
      setState(() {
        this.tarefas = repository.read();
      });
    }
  }

  Future<bool> confirmarExclusao(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
              title: Text('Confirma a exclusão da tarefa?'),
              actions: [
                FlatButton(
                  child: Text('Não'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () => Navigator.of(context).pop(true),
                )
              ]);
        });
  }

  bool canEdit = false;
  var cor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => setState(() => canEdit = !canEdit))
        ],
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (_, indice) {
          var tarefa = tarefas[indice];
          return Dismissible(
            key: Key(tarefa.texto),
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.amber[700],
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                Icons.highlight_off,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                repository.delete(tarefa.texto);
                setState(() => this.tarefas.remove(tarefa));
              } else if (direction == DismissDirection.startToEnd) {
                tarefa.emFalta = true;
              }
            },
            confirmDismiss: (direction) {
              return confirmarExclusao(context);
            },
            child: CheckboxListTile(
              value: tarefa.finalizada,
              subtitle: Text('Quantidade: ' + tarefa.qtde.toString()),
              title: Row(
                children: [
                  canEdit
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed('/edita', arguments: tarefa);
                            if (result) {
                              setState(() => this.tarefas = repository.read());
                            }
                            ;
                          })
                      : Container(),
                  Text(tarefa.texto,
                      style: TextStyle(
                          decoration: tarefa.finalizada
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                ],
              ),
              onChanged: (value) => setState(() {
                tarefa.finalizada = value;
                ordenarLista();
              }),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => adicionarTarefa(context),
      ),
    );
  }
}
