import 'dart:convert';

import 'package:criptocoin/models/moeda.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoedaRepository extends ChangeNotifier {
  List<Moeda> _tabela = [];

  List<Moeda> get tabela => _tabela;

  MoedaRepository() {
    _setupDadosMoedasTable();
  }

  _setupDadosMoedasTable() async {
    String uri = 'https//api.coinbase.com/v2/assets/search?base=BRL';

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> moedas = json['data'];

      moedas.forEach((moeda) {
        final preco = moeda['latest_price'];
        final timestamp = DateTime.parse(preco['timestamp']);
      });
    } // continuar aqui.
  }
}
