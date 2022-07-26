// ignore_for_file: prefer_const_constructors
import 'package:criptocoin/models/moeda.dart';
import 'package:criptocoin/repositories/favoritas_repository.dart';
import 'package:criptocoin/repositories/moeda_repository.dart';
import 'package:criptocoin/views/moedas_detalhes__page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  //Importando classe de moedas.
  late List<Moeda> tabela;

  late MoedaRepository moedas;

  //Biblioteca de conversão de formato de moedas.
  NumberFormat real = NumberFormat.currency(locale: 'pt-BR', name: 'R\$');

  //Lista de moedas selecionadas na lista do App.
  List<Moeda> selecionadas = [];

  late FavoritasRepository favoritas;

  // Função AppBar dinamico com seleção e sem seleção da lista.
  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Cripto Moedas'),
        centerTitle: true,
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel_rounded),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        centerTitle: true,
        backgroundColor: Colors.green[100],
        iconTheme: IconThemeData(color: Colors.black87),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }

  //Função para mostrar detalhes de uma moeda ao fazer o onTap.
  mostrarDetalhes(Moeda moeda) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => MoedasDetalhesPage(moeda: moeda)));
  }

  //Limpar lista selecionadas.
  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  // Build Principal App.
  @override
  Widget build(BuildContext context) {
    //Metodo 1 para chamar favoritas.
    //favoritas = Provider.of<FavoritasRepository>(context);

    //Metodo 2 para chamar favoritas.
    favoritas = context.watch<FavoritasRepository>();

    moedas = context.watch<MoedaRepository>();

    tabela = moedas.tabela;

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              leading: (selecionadas.contains(tabela[moeda]))
                  ? CircleAvatar(child: Icon(Icons.check))
                  : SizedBox(
                      width: 40,
                      child: Image.network(tabela[moeda].icone),
                    ),
              title: Row(
                children: [
                  Text(
                    tabela[moeda].nome,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (favoritas.lista.contains(tabela[moeda]))
                    SizedBox(
                      width: 20,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                ],
              ),
              trailing: Text(real.format(tabela[moeda].preco)),
              selected: selecionadas.contains(tabela[moeda]),
              selectedTileColor: Colors.green[100],
              selectedColor: Colors.black54,
              onLongPress: () {
                setState(() {
                  (selecionadas.contains(tabela[moeda]))
                      ? selecionadas.remove(tabela[moeda])
                      : selecionadas.add(tabela[moeda]);
                });
              },
              onTap: () => mostrarDetalhes(tabela[moeda]),
            );
          },
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: tabela.length),

      //Botão de favoritar.
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.salveAll(selecionadas);
                limparSelecionadas();
              },
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(Icons.star),
            )
          : null,
    );
  }
}
