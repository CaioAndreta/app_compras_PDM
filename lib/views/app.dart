import 'package:flutter/material.dart';
import 'package:projeto_tarefas/views/edita.page.dart';
import 'package:projeto_tarefas/views/lista.page.dart';
import 'package:projeto_tarefas/views/nova.page.dart';

class App extends StatelessWidget {
  //Método responsável por desenhar a tela do aplicativo.
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ListaPage(),
      routes: {
        '/': (context) => ListaPage(),
        '/nova': (context) => NovaPage(),
        '/edita': (context) => EditaPage(),
      },
      initialRoute: '/',
    );
  }
}
