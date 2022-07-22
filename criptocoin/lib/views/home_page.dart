// ignore_for_file: prefer_const_constructors

import 'package:criptocoin/views/Favoritas_Page.dart';
import 'package:criptocoin/views/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variavel para controlar o indice das paginas.
  int paginaAtual = 0;

  //Controlador de slider pc.
  late PageController pc;

  @override
  void initState() {
    //Todo: implementar initState.
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: [
          MoedasPage(),
          FavoritasPage(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.green[100],
          indicatorColor: Colors.green[300],
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          selectedIndex: paginaAtual,
          onDestinationSelected: (pagina) => {
            pc.animateToPage(pagina,
                duration: Duration(milliseconds: 400), curve: Curves.ease)
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Icons.list_alt_outlined,
                  size: 30,
                ),
                label: 'Todos'),
            NavigationDestination(
                icon: Icon(
                  Icons.favorite_outline,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Icons.favorite,
                  size: 30,
                ),
                label: 'Favoritos'),
          ],
        ),
      ),
    );
  }
}
