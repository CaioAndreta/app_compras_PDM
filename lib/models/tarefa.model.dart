class Tarefa {
  String id;
  String texto;
  int qtde;
  bool emFalta;
  bool finalizada;

  Tarefa({this.id, this.texto, this.qtde, this.emFalta, this.finalizada = false});
}
