import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/novo_orcamento.dart';
import 'package:flutter_application_2/pages/settings.dart';
import 'package:flutter_application_2/pages/tela_conteudo.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<FileSystemEntity> arquivos = [];

  @override
  void initState(){
    super.initState();
    carregarArquivos();
  }
  
  


  Future<void> carregarArquivos() async {
    final diretorio = await getApplicationDocumentsDirectory();
    final lista = diretorio.listSync().where((file) => file.path.endsWith('.txt')).toList();
    setState(() {
      arquivos = lista;
    });
  }

  void abrirArquivo(File arquivo) async {
      final conteudo = await arquivo.readAsString();
      Navigator.of(context).push(
        MaterialPageRoute( 
          builder: (_) => TelaConteudo(
            nome: arquivo.path.split('/').last,
            conteudo: conteudo,
          ),
        ),
        
      );
     
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text('Orçamentos'),

      ),
      
      drawer: Drawer(
        child: Container(
          color: Colors.orange.shade100,
          child: ListView(
            children: [
              DrawerHeader(child: Center(child: Text('0.0.1', style: TextStyle(fontSize: 12),))),

              // Icone drawer home
              ListTile(
                leading:  Icon(Icons.home),
                title: Text(
                  'Home'
                ),
                onTap: () => Navigator.pop(context),
              ),

              //  Icone Drawer Config
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Configurações'
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Settings(),),
                  );
                }
              )
              
            ],
          ),
        ),
      ),


      backgroundColor:(Colors.orange.shade50),
      


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade300,
        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => NovoOrcamento(),),);},
        child: const Icon(Icons.add),),

    body: ListView.builder(
        itemCount: arquivos.length,
        itemBuilder: (context, index) {
          final arquivo = arquivos[index] as File;
          final nome = arquivo.path.split('/').last;
          return ListTile(
            title: Text(nome),
            trailing: Icon(Icons.arrow_forward_ios),
           // onTap: () => abrirArquivo(arquivo),
          );
    
  }
    ),
    );
  

      
    

  }
}