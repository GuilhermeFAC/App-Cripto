// ignore_for_file: prefer_const_constructors

import 'package:criptocoin/models/moeda.dart';
import 'package:criptocoin/repositories/moeda_repository.dart';
import 'package:criptocoin/views/moedas_detalhes__page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> with TickerProviderStateMixin {
  //Importando classe de moedas.
  final tabela = MoedaRepository.tabela;

  //Biblioteca de conversão de formato de moedas.
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

  //Lista de moedas selecionadas na lista do App.
  List<Moeda> selecionadas = [];

  //Variavel para controlar o start da animação e parar
  bool showFAB = true;

  //Duração da animação
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward();

  //Animação do botão ao aparecer.
  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _animation.dispose();
  }

  // Função AppBar dinamico com seleção e sem seleção da lista.
  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return SliverAppBar(
        title: Text('Cripto Moedas'),
        centerTitle: true,
        snap: true,
        floating: true,
      );
    } else {
      return SliverAppBar(
        snap: true,
        floating: true,
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

  //Função para mostrar detalhes de uma moeda ao fazer o onTap
  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context, MaterialPageRoute(
      builder: (_) => MoedasDetalhesPage(moeda: moeda))
    );
  }

  // Build Principal App.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, __) => [
          appBarDinamica(),
        ],

        //Condição para ativar e desativar o botão da tela ao fazer o scroll quando selecionado algo na lista.
        body: NotificationListener<UserScrollNotification>(
          onNotification: (scroll) {
            if (scroll.direction == ScrollDirection.reverse && showFAB) {
              _controller.reverse();
              showFAB = false;
            } else if (scroll.direction == ScrollDirection.forward &&
                !showFAB) {
              _controller.forward();
              showFAB = true;
            }
            return true;
          },
          child: ListView.separated(
              itemBuilder: (BuildContext context, int moeda) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading: (selecionadas.contains(tabela[moeda]))
                      ? CircleAvatar(child: Icon(Icons.check))
                      : SizedBox(
                          width: 40,
                          child: Image.asset(tabela[moeda].icone),
                        ),
                  title: Text(
                    tabela[moeda].nome,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
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
        ),
      ),

      //Botão de favoritar.
      floatingActionButton: selecionadas.isNotEmpty
          ? ScaleTransition(
              scale: _animation,
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text(
                  'FAVORITAR',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.star),
              ),
            )
          : null,
    );
  }
}
