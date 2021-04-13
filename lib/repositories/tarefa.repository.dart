
import 'package:projeto_tarefas/models/tarefa.model.dart';

class TarefaRepository {
  static List<Tarefa> tarefas = List<Tarefa>();

  void create(Tarefa produto) {
    tarefas.add(produto);
    print(tarefas);
  }

  void delete(String texto) {
    final produto = tarefas.singleWhere((t) => t.texto == texto);
    tarefas.remove(produto);
    ;
  }

  void update(Tarefa newTarefa, Tarefa oldTarefa) {
    final produto = tarefas.singleWhere((t) => t.texto == oldTarefa.texto);
    produto.texto = newTarefa.texto;
    produto.qtde = newTarefa.qtde;
  }

  void emFalta(String texto) {}
  List<Tarefa> read() {
    return tarefas;
  }
}
