import 'package:flutter/material.dart';

class TelaConteudo extends StatelessWidget {
  final String nome;
  final String conteudo;

  TelaConteudo({required this.nome, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(nome)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SelectableText(conteudo),
      ),
    );
  }
}