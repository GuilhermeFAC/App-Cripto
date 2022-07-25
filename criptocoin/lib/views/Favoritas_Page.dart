// ignore_for_file: prefer_const_constructors

import 'package:criptocoin/repositories/favoritas_repository.dart';
import 'package:criptocoin/widgets/moeda_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({Key? key}) : super(key: key);

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Moedas Favoritas'),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(12.0),
            child: Consumer<FavoritasRepository>(
              builder: (context, favoritas, child) {
                return favoritas.lista.isEmpty
                    ? ListTile(
                        leading: Icon(Icons.favorite),
                        title: Text(
                          'Ainda não há moedas favoritas',
                        ))
                    : ListView.builder(
                        itemCount: favoritas.lista.length,
                        itemBuilder: (_, index) {
                          return MoedaCard(moeda: favoritas.lista[index]);
                        });
              },
            )));
  }
}
