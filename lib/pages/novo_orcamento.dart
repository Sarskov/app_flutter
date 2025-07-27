import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class NovoOrcamento extends StatefulWidget {
  @override
  _NovoOrcamentostate createState() => _NovoOrcamentostate();
}

class _NovoOrcamentostate extends State<NovoOrcamento> {
  List<String> nomesBotoes = [
  'Int Simples', 'Int Paralelo', 'Int Intermediario', 'Tmd 10A', 'Tmd 20A',
  'Tmd 220v', 'Cego', 'Furado', 'Coaxial/RJ', '4X2 P/1',
  '4X2 P/2', '4X2 P/3', '4X4 P/2', '4X4 P/4', '4X4 P/6'
];



  static const int linhas = 5;
  static const int colunas = 3;
  final int total = linhas * colunas;

  List<int> contadores = List.filled(15, 0); // 15 posições (3 x 5)

  void incrementar(int index){
    setState(() {
      contadores[index]++;
    });
  }


  // F U N C A O   P A R A   M O S T R A R   O   P O P U P
  Future<void> mostrarPopupConfirmacao(String nomeArquivo) async {
  if (!mounted) return;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Arquivo Salvo'),
        content: Text('O arquivo "$nomeArquivo" foi salvo com sucesso.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}




  // F U N Ç A O   P A R A   S A L V A R  O  A R Q U I V O
  Future<void> salvarCliqueEmArquivo() async{
    final diretorio = await getApplicationDocumentsDirectory();
    // Pega um diretorio ja incluso noapp e usa ele para salvar os arquivos que vou criar
    // Usa o pacote do path provider

    final agora = DateTime.now();
    final nomeArquivo = 'Orçamento ${agora.day}-${agora.month}-${agora.year}.txt';
    final arquivo = File('${diretorio.path}/$nomeArquivo');

    String conteudo = '';
    for (int i = 0; i < contadores.length; i++){
      conteudo += '${nomesBotoes[i]}: ${contadores[i]} cliques\n';
    }

    await arquivo.writeAsString(conteudo);
    await mostrarPopupConfirmacao(nomeArquivo);

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // A P P B A R
      appBar: AppBar(
        title:Text('Novo Orçamento') ,
        backgroundColor: (Colors.orangeAccent),
      ),

      // C O R P O   DA   T E L A
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: total,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colunas,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => incrementar(index),
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nomesBotoes[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Salvar'),
              onPressed: ( salvarCliqueEmArquivo),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
